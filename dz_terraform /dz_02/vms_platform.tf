variable "vms_resources" {                               # Задача №6
    type = map(any)
    default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    },
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

variable "vm_metadata" {
  type = object({serial-port-enable = number, ssh-keys = string})
  default = { serial-port-enable = 1, ssh-keys= "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOoev5jqN92osASI07AwpFhwWBrJtXhNDzxTMX6fNu07 aleksandrov_sp@aleksandrov-sp-test"}
}


# Блок по заданию №2   ВМ1
variable "image_name" {
  type        = string
  default     = "ubuntu-2004-lts"       
  description = "ubuntu release name"
}

variable "vm_web_core" {
  type        = number
  default     = 2      
  description = "number of processor cores"
}

variable "vm_web_memory" {
  type        = number
  default     = 1      
  description = "ubuntu release name"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 5     
  description = "virtual cpu performance value"
}

variable "vm_web_name" {                         #  Использую для local переменой  ЗАДАНИЕ 5
  type        = string
  default     = "web" #"netology-develop-platform-web"     
  description = "web"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"    
  description = "platform for vm"
}

# Блок по заданию №3   ВМ2


variable "custom_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "prod_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name_prod" {
  type        = string
  default     = "prod"
  description = "VPC network & subnet name"
}

#variable "vm_db_core" {
#  type        = number
#  default     = 2      
#  description = "number of processor cores"
#}

#variable "vm_db_memory" {
#  type        = number
#  default     = 2      
#  description = "ubuntu release name"
#}

#variable "vm_db_core_fraction" {
#  type        = number
#  default     = 20     
#  description = "virtual cpu performance value"
#}

variable "vm_db_name" {                       #  Использую для local переменой ЗАДАНИЕ 5
  type        = string
  default     = "db"     
  description = "db"
}

