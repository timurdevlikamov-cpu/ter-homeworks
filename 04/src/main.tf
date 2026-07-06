
module "vpc_dev" {
  source = "./vpc"
  env_name = var.env_name

  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" }
  ]
}

module "vpc_prod" {
  source   = "./vpc"
  env_name = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
  ]
}


### Cloud init template
data "template_file" "cloudinit" {
   template = file("./cloud-init.yml")
   vars = {
     ssh_keys = "\n      - ${file(var.vms_ssh_root_key)}"
   }
}

### marketing module

module "marketing_vm" {
  source      = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name    = "develop"
  network_id = module.vpc_dev.network_id
  subnet_ids = [module.vpc_dev.subnet_ids[var.vpc_cidr]]
  subnet_zones = [var.default_zone]
  instance_name = "marketing-server"
  instance_count = 1
  image_family  = "ubuntu-2004-lts"
  public_ip     = true

  labels = {
    owner = var.vm_owner,
    project = var.marketing_project_name
  }

  metadata = {
    user-data = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

/*
module "mysql_cluster_example" {
  source = "./mysql_cluster"
  cluster_name = "${var.env_name}-mysql-cluster"
  network_id = module.vpc_dev.network_id
  #ha = false
  ha = true

  subnet_a_id  = module.vpc_dev.subnet_ids["10.0.1.0/24"]
  subnet_b_id  = module.vpc_dev.subnet_ids["10.0.2.0/24"]
}

module "mysql_db_example" {
  source = "./mysql_db"
  cluster_id = module.mysql_cluster_example.cluster_id
  database_name = "exmpl_database"
  user_name = "exmpl_user"
  user_password = "very-strong-pass-1q2w3e"
}
*/

/*
module "s3_bucket" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=master"
  bucket_name = "my-homework-bucket-${var.env_name}"
  folder_id = var.folder_id
  max_size    = 1073741824
}
*/

resource "vault_kv_secret_v2" "new_secret" {
  mount = "secret"
  name = "my-terraform-secret"

  data_json = jsonencode({
    username = "admin"
    password = "super-secret-password-123"
    api_key  = "abcde-12345-fghij"
  })
}
