###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

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

###network vars

variable "env_name" {
  type    = string
  default = "develop"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

#variable "vpc_name" {
#  type        = string
#  default     = "develop"
#  description = "VPC network&subnet name"
#}

#variable "subnet_a_cidr" {
#  type    = string
#  default = "10.0.1.0/24"
#}

#variable "subnet_b_cidr" {
#  type    = string
#  default = "10.0.2.0/24"
#}

###vm vars
variable "marketing_project_name" {
  type    = string
  default = "marketing"
}

#variable "analytics_project_name" {
#  type    = string
#  default = "analytics"
#}

variable "vm_owner" {
  type    = string
  default = "t.devlikamov"
}

###mysql
#variable "mysql_ha" {
#  type = bool
#  description = "Enable HA for mysql"
#  default = true
#}

###ssh vars
variable "vms_ssh_root_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
  default     = "~/.ssh/id_rsa_yandex.pub"
}

variable "s3_access_key" {
  type = string
}

variable "s3_secret_key" {
  type = string
}

#variable "vault_token" {
#  description = "Vault access token"
#  type = string
#  sensitive = true
#}

variable "ip_address" {
  type = string
  description = "ip-address"
  default = "192.168.0.1"
  #default = "1920.1680.0.1"

  validation {
    ## Thanks google
    condition = can(regex("^((25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)\\.?\\b){4}$", var.ip_address))
    error_message = "Ошибка валидации ип-адреса"
  }
}

variable "ip_list" {
  type = list(string)
  description = "ip-address list"
  default = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
  #default = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]

  validation {
    condition = alltrue([
      ## Thanks again
      for ip in var.ip_list : can(regex("^((25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)\\.?\\b){4}$", ip))
    ])
    error_message = "Ошибка: один из ип-адресов wrong"
  }
}

variable "lowercase_only" {
  type = string
  description = "any lower case string"
  default = "i'm devops"
  #default = "I'm a devops"

  validation {
    condition = !can(regex("[A-Z]", var.lowercase_only))
    error_message = "Error: only lower case allowed, buddy"
  }
}

variable "in_the_end_there_can_be_only_one" {
  description = "Who is better Connor or Duncan?"
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
  })

  default = {
    Dunkan = true
    Connor = false
  }

  validation {
    error_message = "There can be only one MacLeod"
    condition = var.in_the_end_there_can_be_only_one.Dunkan != var.in_the_end_there_can_be_only_one.Connor
  }
}
