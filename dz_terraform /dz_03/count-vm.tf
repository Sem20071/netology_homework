data "yandex_compute_image" "ubuntu" {
  family = var.image_name     
}

resource "yandex_compute_instance" "web_vms" {
  count       = 2
  name        = "netology-develop-web-${count.index + 1}"                                                              
  platform_id = var.vm_platform_id
  depends_on  = [yandex_compute_instance.db_vms]
  hostname    = "netology-develop-web-${count.index + 1}"
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
  
   metadata = local.vm_metadata #local.vms_ssh_root_key
}