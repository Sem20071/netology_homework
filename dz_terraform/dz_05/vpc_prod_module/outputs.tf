#output "network_id_value" {
#  description = "ID созданной VPC-сети"
#  value = yandex_vpc_network.prod.id
#}

#output "subnet_id_value" {
#  description = "ID подсети"
#  value = [yandex_vpc_subnet.prod_a.id]
#}

#output "subnet_zone_value" {
#  value = [yandex_vpc_subnet.prod_a.zone]
#}

output "subnet_prod_a" {
  description = "subnet info"
  value = yandex_vpc_subnet.prod_a
}
output "vpc_security_group_prod" {
  description = "securrity group prod info"
  value = yandex_vpc_security_group.prod
}