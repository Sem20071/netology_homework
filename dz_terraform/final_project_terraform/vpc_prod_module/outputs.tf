output "network_prod" {
  description = "subnet info"
  value = yandex_vpc_network.prod
}

output "subnet_prod_a" {
  description = "subnet info"
  value = yandex_vpc_subnet.prod_a
}
output "vpc_security_group_prod" {
  description = "securrity group prod info"
  value = yandex_vpc_security_group.vpc_sec_prod
}