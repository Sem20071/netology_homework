# terraform {
#   required_providers {
#     yandex = {
#       source = "yandex-cloud/yandex"
#     }
#   }
#   required_version = "~>1.8.4"
# }

# provider "yandex" {
# #  token     = var.token
#   cloud_id  = var.cloud_id
#   folder_id = var.folder_id
#   zone      = var.default_zone
#   service_account_key_file = file("~/.ssh/authorized_key.json")
# }

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4" 
}


# resource "yandex_vpc_network" "prod" {
#   name = var.network_name
# }

#создаем подсеть
# resource "yandex_vpc_subnet" "prod_a" {
#   name           = var.subnet_name
#   zone           = var.subnet_zone
#   network_id     = yandex_vpc_network.prod.id
#   v4_cidr_blocks = var.cidr_blocks
# }