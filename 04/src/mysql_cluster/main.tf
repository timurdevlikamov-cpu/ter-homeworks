
locals {
  actual_host_count = var.ha ? 2 : 1    ## 2 host = HA, else 1
  zones = ["ru-central1-a", "ru-central1-b"]
}

resource "yandex_mdb_mysql_cluster" "this" {
  name = var.cluster_name
  network_id = var.network_id
  #host_count = local.actual_host_count
  environment = "PRESTABLE"
  version = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id = "network-ssd"
    disk_size = 10
  }

  dynamic "host" {
    for_each = range(local.actual_host_count)

    content {
      zone      = host.value == 1 ? "ru-central1-a" : "ru-central1-b"
      subnet_id = host.value == 1 ? var.subnet_a_id : var.subnet_b_id
    }
  }
  
}
