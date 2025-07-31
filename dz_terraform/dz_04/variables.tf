###cloud vars

#variable "public_key" {
#  type    = string
#  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGiVcfW8Wa/DxbBNzmQcwn7hJOj7ji9eoTpFakVnY/AI webinar"
#}

variable "vms_ssh_root_key" {
  type        = string
  sensitive   = true
  default     = "value"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

#variable "vpc_module_source" {
 # type        = string
 # default     = "./vpc_prod_module"
 # description = "source module"
#}

variable "vpc_network_name" {
  type        = string
  default     = "value"
  description = "vpc_prod_module variable network_name"
}

variable "vpc_subnet_name" {
  type        = string
  default     = "value"
  description = "vpc_prod_module variable subnet_name"
}

variable "vpc_subnet_zone" {
  type        = string
  default     = "value"
  description = "vpc_prod_module variable subnet_zone"
}

variable "vpc_cidr_blocks" {
  type        = string
  default     = "value"
  description = "vpc_prod_module variable cidr_blocks"
}

variable "vpc_network_id" {
  type        = string
  default     = "value"
  description = "vpc_prod_module variable network_id"
}