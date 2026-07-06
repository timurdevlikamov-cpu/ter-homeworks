variable "env_name" {
    type = string
    description = "Env name (develop for exmpl)"
}

#variable "zone" {
#    type = string
#    description = "Access zone (ru-central1-a for exmpl)"
#}

#variable "cidr" {
#  type = string
#  description = "CIDR block for subnet"
#}

#variable "network_name" {
#  type = string
#  default = "my-vpc"
#}

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
}
