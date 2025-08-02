

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
  count       = 2
  name        = "final-project-vm-${count.index + 1}"                                                              
  platform_id = var.vm_platform_id
  depends_on = [module.vpc_prod_module]
  hostname    = "final-project-vm-${count.index + 1}"
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

scheduling_policy {
    preemptible = true                     # Прерываемая нужна ?
  }
  network_interface {
    subnet_id          = module.vpc_prod_module.subnet_prod_a.id
    nat                = true
    security_group_ids = [module.vpc_prod_module.vpc_security_group_prod.id]      
  }
  
   metadata = var.vm_metadata
}




#   scheduling_policy {
#     preemptible = true
#   }
#   network_interface {
#     subnet_id          = yandex_vpc_subnet.develop.id
#     nat                = true
#     security_group_ids = [yandex_vpc_security_group.example.id]              # Задание 1
#   }
  
#    metadata = local.vm_metadata #local.vms_ssh_root_key
# }




