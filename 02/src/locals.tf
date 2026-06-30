<<<<<<< Updated upstream
locals {

  web_vm_name = "${var.vpc_name}-${var.vm_web_name}"
  db_vm_name  = "${var.vpc_name}-${var.vm_db_name}"

  common_metadata = {
    "serial-port-enable" = "1"
    "ssh-keys"           = "ubuntu:${var.vms_ssh_public_root_key}"
  }

}
=======
locals {

  web_vm_name = "${var.vpc_name}-${var.vm_web_name}"
  db_vm_name  = "${var.vpc_name}-${var.vm_db_name}"

  common_metadata = {
    "serial-port-enable" = "1"
    "ssh-keys"           = "ubuntu:${var.vms_ssh_public_root_key}"
  }

}
>>>>>>> Stashed changes
