resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# Cloud Nat
resource "yandex_vpc_gateway" "nat_gateway" {
  name = "${var.vpc_name}-nat-gateway"
}

# Table route
resource "yandex_vpc_route_table" "develop_rt" {
  name       = "${var.vpc_name}-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
      destination_prefix = "0.0.0.0/0"
      gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

# Web VM (default_zone)
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  route_table_id = yandex_vpc_route_table.develop_rt.id
  v4_cidr_blocks = var.default_cidr
}

# DB VM (ru-central1-b)
resource "yandex_vpc_subnet" "db_subnet" {
  name           = "${var.vpc_name}-db-subnet"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
  route_table_id = yandex_vpc_route_table.develop_rt.id
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}

data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_image_family
}

# Web VM resources

resource "yandex_compute_instance" "platform" {
  name        = local.web_vm_name
  platform_id = var.vm_web_platform_id

  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    #nat       = true
    nat       = false
  }

  #metadata = var.common_metadata
  metadata = local.common_metadata

}

# DB VM resources

resource "yandex_compute_instance" "database" {
  name        = local.db_vm_name
  platform_id = var.vm_db_platform_id
  zone        = "ru-central1-b"

  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.db_subnet.id
    #nat       = true
    nat       = false
  }

  #metadata = var.common_metadata
  metadata = local.common_metadata

}
