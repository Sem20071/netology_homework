resource "yandex_compute_instance" "db" {                 # Задание 2.2 не доделано !!!
  count       = 2
  name        = "netology-develop-web-${count.index + 1}"                                                              
  platform_id = var.vm_platform_id
  
  resources {
    cores         = var.vms_resources.web.cores                           
    memory        = var.vms_resources.web.memory                          
    core_fraction = var.vms_resources.web.core_fraction           
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]              # Задание 1
  }
  
  metadata = var.vm_metadata
}