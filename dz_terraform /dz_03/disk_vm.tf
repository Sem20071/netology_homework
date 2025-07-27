resource "yandex_compute_disk" "disk_group" {
    count    = 3
    name     = "netology-develop-disk-${count.index + 1}" 
    size     = 1
    type     = "network-hdd"
    image_id = ""
    zone     = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name        = "netology-develop-storge"                                                              
  platform_id = var.vm_platform_id
  hostname    = "netology-develop-storge"
  resources {
    cores         = var.storage_resources.storage.cores                           
    memory        = var.storage_resources.storage.memory                          
    core_fraction = var.storage_resources.storage.core_fraction           
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk"{
    for_each = yandex_compute_disk.disk_group
    content {
        disk_id = secondary_disk.value.id
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
  
  metadata = local.vm_metadata
      
}