data "yandex_compute_image" "ubuntu_db" {
    family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "db" {
  
  for_each = {for vm in var.each_vm : vm.vm_name => vm}

  name        = "db-${each.value.vm_name}"
  platform_id = var.vm_platform_id
  allow_stopping_for_update = true

  resources {
    cores   = each.value.cpu
    memory  = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id  = data.yandex_compute_image.ubuntu_db.image_id
      size      = each.value.disk_volume
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat = true
  }

  metadata = {
    #ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}
