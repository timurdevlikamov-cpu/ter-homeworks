terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.12.0"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

provider "aws" {
  #region = "ru-central1"
  region = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check = true
  skip_requesting_account_id = true

  endpoints {
    s3 = "https://storage.yandexcloud.net"
  }

  access_key = var.s3_access_key
  secret_key = var.s3_secret_key
}

provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = var.vault_token
}

data "vault_generic_secret" "vault_example" {
    path = "secret/example"
  }
