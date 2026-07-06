variable "cluster_id" {
  description = "ID MySQL cluster"
  type = string
}

variable "database_name" {
  description = "Database Name"
  type = string
}

variable "user_name" {
  description = "Just new user name"
  type = string
}

variable "user_password" {
  description = "User pass"
  type = string
  sensitive = true
}
