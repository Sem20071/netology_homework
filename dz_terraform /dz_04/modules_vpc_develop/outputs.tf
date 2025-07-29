output "network_id_value" {
  description = "ID созданной VPC-сети"
  value = yandex_vpc_network.develop.id
}

output "subnet_id_value" {
  description = "ID подсети"
  value = [yandex_vpc_subnet.develop_a.id]
}

output "subnet_zone_value" {
  value = [yandex_vpc_subnet.develop_a.zone]
}

