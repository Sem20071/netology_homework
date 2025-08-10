resource "yandex_container_registry" "my-registry" {
  name      = var.yc_registry_name
  folder_id = var.folder_id

  labels = {
    environment = "production"
    terraform   = "true"
  }
}

# Создание репозитория в registry
resource "yandex_container_repository" "my-docker-repo" {
  name = "${yandex_container_registry.my-registry.id}/my-app"
}
# Создание сервисного аккаунта для доступа к реестру
resource "yandex_iam_service_account" "registry-user" {
  name        = "registry-user"
  description = "Service account for pulling containers from YCR"
}
# Назначение прав
resource "yandex_resourcemanager_folder_iam_binding" "puller_binding" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  
  members = [
    "serviceAccount:${yandex_iam_service_account.registry-user.id}",
  ]
}
# Создание ключа доступа для созданного аккаунта
resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id = yandex_iam_service_account.registry-user.id
  description        = "Static access key for container puller"
}

output "access_key" {
  value = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  sensitive = true
}

output "secret_key" {
  value = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  sensitive = true
}





resource "yandex_container_registry_ip_permission" "my_ip_permission" {
  registry_id = yandex_container_registry.my-registry.id
  pull        = ["${yandex_compute_instance.project.network_interface[0].nat_ip_address}/32"]
  depends_on = [yandex_compute_instance.project]
 }

resource "yandex_container_registry_iam_binding" "public_pull" {
  registry_id = yandex_container_registry.my-registry.id
  role        = var.yc_registry_role
  depends_on = [yandex_container_registry.my-registry]
  members = [
    "system:allUsers",  
  ]
}

# Инфа для доступа к БД для передачи в контейнер
resource "local_file" "env_file" {
  filename = "${path.module}/app/.env"
  content  = <<-EOT
    DB_HOST=${yandex_mdb_mysql_cluster.prod-mysql.host[0].fqdn}
    DB_NAME=${var.db_name}
    DB_USER=${var.db_user}
    DB_PASS=${var.db_pass}
  EOT
  file_permission = "0600"

  depends_on = [yandex_mdb_mysql_cluster.prod-mysql]
}
# Создание и отправка образа в registry
resource "null_resource" "push_docker_images" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = <<-EOT
      # Аутентификация в Yandex Container Registry
      yc container registry configure-docker --force

      # Переходим в директорию с проектом
      cd ${path.module}/app

      # Собираем и запускаем сервисы
      docker compose build
     
      # Помечаем и загружаем все сервисы в наш реестр
        docker tag "app-web:latest" "cr.yandex/${yandex_container_registry.my-registry.id}/app-web:latest"
        docker push "cr.yandex/${yandex_container_registry.my-registry.id}/app-web:latest"

    EOT
  }

  depends_on = [
    yandex_container_repository.my-docker-repo,
    yandex_mdb_mysql_cluster.prod-mysql
    ]
  
}


