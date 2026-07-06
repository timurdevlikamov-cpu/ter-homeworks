
output "vpc_dev_info" {
    description = "Some Dev infra"
    value = {
        network_id = module.vpc_dev.network_id
        subnets = module.vpc_dev.subnet_ids
    }
}

output "vpc_prod_info" {
    description = "Some Prod infra"
    value = {
        network_id = module.vpc_prod.network_id
        subnets = module.vpc_prod.subnet_ids
    }
}

output "vault_example_key" {
  value     = nonsensitive(data.vault_generic_secret.vault_example.data["test"])
}

output "new_secret_username" {
    value = nonsensitive(jsondecode(vault_kv_secret_v2.new_secret.data_json)["username"])
}

output "new_secret_all_data" {
    value = nonsensitive(jsondecode(vault_kv_secret_v2.new_secret.data_json))
}

