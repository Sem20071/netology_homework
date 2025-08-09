variable "subnet_name" {
  type = string
}

variable "subnet_zone" {
  type = string
}

variable "network_id" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}

variable "network_name" {
  type = string
}
variable "folder_id" {
  type = string
}


variable "security_group_egress" {
  description = "secrules egress"
  type = list(object(
    {
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
  }))
  default = [
    { 
      protocol       = "TCP"
      description    = "разрешить весь исходящий трафик"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = 0
      to_port        = 65365
    }
  ]
}

variable "security_group_ingress" {
  description = "secrules ingress"
  type = list(object(
    {
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "разрешить входящий ssh"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 22
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий  http"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 80
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий https"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 443
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий  http для работы с mini-app"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 8080
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий  http для работы с mini-app"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 8090
    },
     {
       protocol       = "TCP"
       description    = "разрешить входящий mysql"
       v4_cidr_blocks = ["0.0.0.0/0"]
       port           = 3306
     },
  ]
}