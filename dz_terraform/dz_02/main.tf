resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone                                           
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.image_name                                                        #"ubuntu-2004-lts"
}
resource "yandex_compute_instance" "platform" {
  name        = local.name_vm_web                                 #var.vm_web_name                                    ЗАДАНИЕ 5
  platform_id = var.vm_platform_id
  
  resources {
    cores         = var.vms_resources.web.cores                      #var.vm_web_core                                              
    memory        = var.vms_resources.web.memory                     #var.vm_web_memory                                            
    core_fraction = var.vms_resources.web.core_fraction              #var.vm_web_core_fraction                                     
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
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  
  metadata = var.vm_metadata
 # metadata = {
 #   serial-port-enable = 1
 #   ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
 # }

}
# блок задания №3

resource "yandex_vpc_subnet" "prod" {    #prod
  name           = var.vpc_name_prod          
  zone           = var.custom_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.prod_cidr
}

resource "yandex_compute_instance" "platform-db" {     
  name        = local.name_vm_db                     #var.vm_db_name              ЗАДАНИЕ №5                                          
  platform_id = var.vm_platform_id
  zone        = var.custom_zone                                      
  resources {
    cores         = var.vms_resources.db.cores                                              
    memory        = var.vms_resources.db.memory                                            
    core_fraction = var.vms_resources.db.core_fraction                                 
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
    subnet_id = yandex_vpc_subnet.prod.id
    nat       = true
  }


  metadata = var.vm_metadata
  #metadata = {
  #  serial-port-enable = 1
  #  ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
 # }

}
