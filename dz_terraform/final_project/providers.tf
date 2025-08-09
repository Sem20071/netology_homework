terraform {
  required_providers {
    template  = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"         #Актуальная версия провайдера  hashicorp/template
    }
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.146.0"          #Актуальная версия провайдера yandex-cloud
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"           #Актуальная версия провайдера local
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"           #Актуальная версия провайдера null
    }
  }
  required_version = "~>1.8.4"
  backend "s3" {
    endpoints = {
      s3           = "https://storage.yandexcloud.net"
      dynamodb     = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g7g5qur1nsh9pakjnj/etnfbmf8tf5igntqssd2" 
    }
    bucket                      = "private-tfstate"
    region                      = "ru-central1"
    key                         = "terraform.tfstate"
    dynamodb_table              = "tfstate-lock"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.vpc_subnet_zone
  service_account_key_file = file("~/.ssh/authorized_key.json")
}
