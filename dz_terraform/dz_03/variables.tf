###cloud vars
#variable "token" {
#  type        = string
#  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "image_name" {
  type        = string
  default     = "ubuntu-2004-lts"       
  description = "ubuntu release name"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"       
  description = "yandex platform"
}

variable "vms_resources" {                                                          
    type = map(any)
    default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
   }
}

variable "vms_ssh_root_key" {                                                             
  type = string
  default = "ssh = "
  description = "ssh-keygen -t ed25519"
  sensitive   = true
  }

variable "vms_ssh_root_key_file" {                                                             
  type = string
  default = ""
  description = "root ssh key file "
  sensitive   = true
  }

variable "vm_metadata" {                                                           
  type = object({serial-port-enable = number, ssh-keys = string})
  default = null
  }


variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number, core_fraction = number }))
  default = [
    {
      vm_name = "netology-develop-db-main",
      cpu = 2,
      ram = 2,
      disk_volume = 15,
      core_fraction = 20
    },
    {
      vm_name = "netology-develop-db-replica",
      cpu = 2,
      ram = 1,
      disk_volume = 10,
      core_fraction = 5
    }
  ]
}

variable "storage_resources" {                                                          
    type = map(any)
    default = {
    storage = {
      cores         = 2
      memory        = 2
      core_fraction = 5
    }
   }
}
