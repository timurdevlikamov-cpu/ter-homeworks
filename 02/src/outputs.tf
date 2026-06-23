output "vm_details" {
  description = "Detailed information about created virtual machines"
  value = {
    web_vm = {
      instance_name = yandex_compute_instance.platform.name
      external_ip   = yandex_compute_instance.platform.network_interface[0].nat_ip_address
      fqdn          = yandex_compute_instance.platform.fqdn
    }
    db_vm = {
      instance_name = yandex_compute_instance.database.name
      external_ip   = yandex_compute_instance.database.network_interface[0].nat_ip_address
      fqdn          = yandex_compute_instance.database.fqdn
    }
  }
}
