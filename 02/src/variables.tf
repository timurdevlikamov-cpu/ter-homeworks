<<<<<<< Updated upstream
###cloud vars


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
  description = "VPC network & subnet name"
}

###ssh vars

variable "vms_ssh_public_root_key" {
  type        = string
  default     = "ssh-rsa <here-is-my-key>"
  description = "ssh-keygen -t ed25519"
}

#variable "common_metadata" {
#  type = map(string)
#  default = {
#    "serial-port-enable" = "1"
#    "ssh-keys"           = "ubuntu:${var.vms_ssh_public_root_key}"
#  }
#}
=======
###cloud vars


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
  description = "VPC network & subnet name"
}

###ssh vars

variable "vms_ssh_public_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDhiRUkycpEfmDLL7lJAg6Qlh5Y+q1+CTJ7yVUePM3xvkAF4Bjdu+nXclCC932HjVXik8siBNfKWuAvFJWbYVHRT+2UY28AmXrrdvwR4auwTkrEZIZbS+Vsd76SgBsq3bgaL1aJAR5V5gPXTCJmU17WicbQ48c8lfiusUeHIrieE6u+G0rrBk3ieVHTscbh5b11EC2Pca50on/upCLzv2JM13Cth2R/jlKTFDjK5dOXzr7zGJ8+tohA9PEDT8npXQ7mfptGjRco4d4iaXZ1bXeqUzDbBmlX7RxyH5swow5QOlTfMf5W03ePbYbARWDGVcx1PSS1D0JZRvv2awHpg9tXN312RinAgl/RPtdnT/kOfuvE5LI6v/X5luTmOaabdSc4RX3dUe6yn7RGtHgP3dH1OGgRsAhJWFkEbSXXVqi2s4LqHraoA79/kcwkmz5IC/wRMlujs408Yn4xP5Hy6tZ1Eyg+otfgQZtkG/Dbh2ZNK0Wm7mjoMp9qRD+BbBiOcoAW32h43ByDCOr0l0VRuNWjiL7UhQOoE3DOfxx2HJ/VteeKD9FnoudlZbKQQnOTwMXS4vhC1e7sQlnQCrk+tqIOVYpqiV4bJGXObL1bJVj9vf3/UoxY7ykeXKeEWM25zukLJ+l3OwLBiD4i3bM27vouiMgi0IpVACXMJQmV8KaA1Q== tdi@DevOps"
  description = "ssh-keygen -t ed25519"
}

#variable "common_metadata" {
#  type = map(string)
#  default = {
#    "serial-port-enable" = "1"
#    "ssh-keys"           = "ubuntu:${var.vms_ssh_public_root_key}"
#  }
#}
>>>>>>> Stashed changes
