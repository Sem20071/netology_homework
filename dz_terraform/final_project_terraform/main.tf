
# Создание сети. через модуль vpc_prod_module
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
# Создание виртуальной машины
resource "yandex_compute_instance" "project" {
  name        = var.vm_name                                                            
  platform_id = var.vm_platform_id
  hostname    = var.vm_name
  depends_on = [
    module.vpc_prod_module,
    yandex_mdb_mysql_cluster.prod-mysql,
    yandex_container_registry.my-registry,
    null_resource.push_docker_images]
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
