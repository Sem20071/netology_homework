terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4"  ### some test
}


resource "yandex_vpc_network" "prod" {
  name = var.network_name
}

#создаем подсеть
resource "yandex_vpc_subnet" "prod_a" {
  name           = var.subnet_name
  zone           = var.subnet_zone
  network_id     = yandex_vpc_network.prod.id
  v4_cidr_blocks = var.cidr_blocks
}
