
data "yandex_compute_image" "ubuntu_web" {
    family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "web" {

    # Number of VMs
    count = 2 

    # for_each-vm.tf runs first
    depends_on = [yandex_compute_instance.db]

    name        = "web-${count.index+1}"
    platform_id = var.vm_platform_id
    allow_stopping_for_update = true

    resources {
      cores = 2
      memory = 2
      core_fraction = 20
    }

    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.ubuntu_web.image_id
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
