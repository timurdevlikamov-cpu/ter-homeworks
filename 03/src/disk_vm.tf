resource "yandex_compute_disk" "extra_disks" {
  
  # Number of virtual disks
  count = 3

  name = "disk-${count.index + 1}"

  # Size
  size = 1

  zone = var.default_zone

  description = "Extra disks"
}

# VM "storage"
#data "yandex_compute_image" "ubuntu_web" {
#    family = "ubuntu-2004-lts"
#}

resource "yandex_compute_instance" "storage_vm" {
    name = "storage"
    platform_id = var.vm_platform_id
    allow_stopping_for_update = true

    resources {
      cores  = 2
      memory = 2
      core_fraction = 20  
    }

    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.ubuntu_web.id
      }
    }

    network_interface {
      subnet_id = yandex_vpc_subnet.develop.id
      security_group_ids = [yandex_vpc_security_group.example.id]
      nat = true
    }

    dynamic "secondary_disk" {
      for_each = yandex_compute_disk.extra_disks

      content {
        disk_id = secondary_disk.value.id
      }
    }

    metadata = {
        ssh-keys = "ubuntu:${local.ssh_public_key}"
    }

}
