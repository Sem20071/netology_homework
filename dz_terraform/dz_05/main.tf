#создаем облачную сеть
#resource "yandex_vpc_network" "develop" {
#  name = "develop"
#}

#создаем подсеть
#resource "yandex_vpc_subnet" "develop_a" {
#  name           = "develop-ru-central1-a"
#  zone           = "ru-central1-a"
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = ["10.0.1.0/24"]
#}

#resource "yandex_vpc_subnet" "develop_b" {
#  name           = "develop-ru-central1-b"
#  zone           = "ru-central1-b"
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = ["10.0.2.0/24"]
#}

module "vpc_prod_module" {
  source         = "./vpc_prod_module"
  network_name   = var.vpc_network_name
  subnet_name    = var.vpc_subnet_name
  subnet_zone    = var.vpc_subnet_zone
  network_id     = var.vpc_network_id
  cidr_blocks    = [var.vpc_cidr_blocks]
}


module "marketing-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "prod" 
  network_id     = module.vpc_prod_module.subnet_prod_a.network_id  #network_id_value
  subnet_zones   = [module.vpc_prod_module.subnet_prod_a.zone]  #subnet_zone_value
  subnet_ids     = [module.vpc_prod_module.subnet_prod_a.id]  #subnet_id_value
  instance_name  = "vm-marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  depends_on = [
    module.vpc_prod_module
  ]
  labels = { 
    owner= "i.ivanov",
    project = "marketing"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "stage"
  network_id     = module.vpc_prod_module.subnet_prod_a.network_id
  subnet_zones   = [module.vpc_prod_module.subnet_prod_a.zone]
  subnet_ids     = [module.vpc_prod_module.subnet_prod_a.id]
  instance_name  = "vm-analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  depends_on = [
    module.vpc_prod_module
  ]
labels = { 
    owner= "i.ivanov",
    project = "analytics"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    vms_ssh_root_key = var.vms_ssh_root_key  # Передача переменной в шаблон
  }
}

