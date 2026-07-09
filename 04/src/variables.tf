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

variable "vault_token" {
  description = "Vault access token"
  type = string
  sensitive = true
}
