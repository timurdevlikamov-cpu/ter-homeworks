
variable "cluster_name" {
  description = "MySQL cluster name"
  type = string
}

variable "network_id" {
  description = "Network ID"
  type = string
}

variable "ha" {
  description = "HA options - on or off"
  type = bool
  default = true
}

#variable "subnet_id" {
#  type = string
#}

#variable "subnets" {
#  type = map(string)
#}

variable "subnet_a_id" {
  type = string
}

variable "subnet_b_id" {
  type = string
}

#variable "host_count" {
#  description = "Number of hosts"
#  type = number
#  default = null
#}

variable "security_group_id" {
  type = list(string)
}

