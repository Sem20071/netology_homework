terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4"  ### some test
}


resource "yandex_vpc_network" "develop" {
  name = var.network_name
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop_a" {
  name           = var.subnet_name
  zone           = var.subnet_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.cidr_blocks
}
