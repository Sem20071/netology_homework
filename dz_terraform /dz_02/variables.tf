###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id" # Вынесен в файл providers.auto.tfvars
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id" # Вынесен в файл providers.auto.tfvars
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
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ubuntu:$(var.vms_ssh_root_key)" # Понимаю что публичный ключ не самая конфидециальная информация, для теста перенес значение в файл personal.auto.tfvars, который добавлен в .gitignore
  description = "ssh-keygen -t ed25519"
  sensitive   = true
}

