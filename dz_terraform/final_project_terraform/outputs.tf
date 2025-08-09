output "registry-id" {
  value = yandex_container_registry.my-registry.id
}

# Вывод информации о загруженных образах
output "pushed_images" {
  value = <<EOT
  Образ загружен в реестр:
  - Web: cr.yandex/${yandex_container_registry.my-registry.id}/web:latest
  EOT
  depends_on = [null_resource.push_docker_images]
}

output "vm-managment-ip" {
  value = yandex_compute_instance.project.network_interface[0].nat_ip_address
}

output "result" {
  value = "Для проверки необходимо использовать адресс http://${yandex_compute_instance.project.network_interface[0].nat_ip_address}:80"
  
}