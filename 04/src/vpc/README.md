## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.12.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [yandex_vpc_network.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR block for subnet | `string` | n/a | yes |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Env name (develop for exmpl) | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | n/a | `string` | `"my-vpc"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Access zone (ru-central1-a for exmpl) | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | n/a |
