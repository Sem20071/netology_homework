

module "vpc_prod_module" {
  source         = "./vpc_prod_module"
  network_name   = var.vpc_network_name
  subnet_name    = var.vpc_subnet_name
  subnet_zone    = var.vpc_subnet_zone
  network_id     = var.vpc_network_id
  cidr_blocks    = [var.vpc_cidr_blocks]
  folder_id      = var.folder_id
}
data "yandex_compute_image" "ubuntu" {
   family = var.image_name     
 }

resource "yandex_compute_instance" "project" {
  name        = var.vm_name                                                            
  platform_id = var.vm_platform_id
  hostname    = var.vm_name
  depends_on = [
    module.vpc_prod_module,
    yandex_mdb_mysql_cluster.prod-mysql,
    yandex_container_registry.my-registry]
  resources {
    cores         = var.vms_resources.vm.cores                           
    memory        = var.vms_resources.vm.memory                          
    core_fraction = var.vms_resources.vm.core_fraction           
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  metadata = {
    user-data = data.template_file.cloudinit.rendered
    serial-port-enable = 1
   }
 
  scheduling_policy {
    preemptible = true                     # Прерываемая нужна ?
  }
  network_interface {
    subnet_id          = module.vpc_prod_module.subnet_prod_a.id
    nat                = true
    security_group_ids = [module.vpc_prod_module.vpc_security_group_prod.id]      
  }
  
}

data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yml")
  vars = {
    vms_ssh_root_key = var.vms_ssh_root_key
    yc_registry_id   = yandex_container_registry.my-registry.id
  }
}

# # Даём 150 секунд для применение настроек cloud-init
# resource "null_resource" "timeout" {
#   depends_on = [yandex_compute_instance.project,null_resource.push_docker_images]

#   provisioner "local-exec" {
#     command = "sleep 150"
#   }
# }

# # Пулим и запускаем контейнер с нашим приложением.
# resource "null_resource" "pull_and_run_container" {
#   depends_on = [yandex_compute_instance.project,null_resource.push_docker_images,null_resource.timeout]

#   provisioner "remote-exec" {
#     inline = [
#       <<-EOT
      
#         # Проверяем установлен ли Docker
#         check_docker() {
#           if command -v docker &>/dev/null; then
#             return 0
#           else
#             echo "Docker не установлен, ожидаем..."
#             return 1
#           fi
#         }

#         # Повторяем проверку с интервалом 20 секунд (максимум 10 попыток = 200 секунд)
#         attempts=0
#         max_attempts=10
#         until check_docker; do
#           attempts=$((attempts+1))
#           if [ $attempts -ge $max_attempts ]; then
#             echo "Ошибка: Docker не установлен после $max_attempts попыток"
#             exit 1
#           fi
#           sleep 20
#         done
#         echo "Docker обнаружен, продолжаем..."

# docker login --username ${access_registry_user} --password ${access_registry_pass} cr.yandex
#         docker pull cr.yandex/${yandex_container_registry.my-registry.id}/app-web:latest
#         docker run -d -p 80:5000 cr.yandex/${yandex_container_registry.my-registry.id}/app-web:latest
#       EOT
#     ]

#     connection {
#       type        = "ssh"
#       user        = var.vm_user_name
#       private_key =  file(var.vms_ssh_privat_key)
#       host        = yandex_compute_instance.project.network_interface[0].nat_ip_address
#     }
#   }
# }
