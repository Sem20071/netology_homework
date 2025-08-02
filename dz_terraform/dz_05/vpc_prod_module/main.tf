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

resource "yandex_vpc_security_group" "prod" {
  name        = "vms-security-group"
  description = "security group for my vms"
  network_id  = yandex_vpc_network.prod.id

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH"
    port          = 22
    v4_cidr_blocks = var.cidr_blocks #
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outgoing traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}