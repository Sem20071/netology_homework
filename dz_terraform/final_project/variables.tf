
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

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

variable "image_name" {
  type        = string
  default     = "ubuntu-2404-lts"       
  description = "ubuntu release name"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"       
  description = "yandex platform"
}

variable "vm_user_name" {
  type        = string
  default     = "ubuntu"       
  description = "vm_user_name"
  sensitive   = true
}

variable "vms_ssh_privat_key" {
  type        = string
  default     = "~/.ssh/id_ed25519"      
  description = "SSH key for VM access"
  sensitive   = true
}


variable "vms_ssh_root_key" {                                                             
  type = string
  default = "ssh = "
  description = "ssh-keygen -t ed25519"
  sensitive   = true
  }

variable "vms_resources" {                                                          
    type = map(any)
    default = {
    vm = {
      cores         = 2
      memory        = 4
      core_fraction = 20
    }
   }
}

# Переменные окружения для ВМ
variable "db_name" {
  type        = string
  default     = "example"       
  description = "DB name"
}

variable "db_pass" {
  type        = string
  default     = "111zzz**"       
  description = "DB password"
}

variable "db_user" {
  type        = string
  default     = "administrator"       
  description = "DB user"
}

variable "vm_name" {
  type        = string
  default     = "final-project-vm-manager"       
  description = "name VM"
}

# Переменные окружения для db 
variable "db_cluster_name" {
  type        = string
  default     = "prod-cluster"       
  description = "db cluster name"
}

variable "db_resources_preset" {
  type        = string
  default     = "s3-c2-m8"      
  description = "db cluster resources preset id"
}

variable "disk_type_db" {
  type        = string
  default     = "network-hdd"      
  description = "db disk type"
}

# Переменные блока registry
variable "yc_registry_name" {
  type        = string
  default     = "my-registry"      
  description = "yc_registry_name"
}

variable "yc_registry_role" {
  type        = string
  default     = "container-registry.images.puller"      
  description = "yc_registry_role"
}
