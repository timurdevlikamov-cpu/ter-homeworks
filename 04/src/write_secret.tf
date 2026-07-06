resource "vault_generic_secret" "my_managed_secret" {
  path = "secret/terraform_is_awesome"
  data_json = jsonencode({
    "status" = "working"
    "message" = "I can manage secrets now!"
  })
}

output "check_managed_secret" {
  value     = nonsensitive(vault_generic_secret.my_managed_secret.data)
  sensitive = false
}
