variable "web_provision" {
  type        = bool
  default     = true
  description = "ansible provision switch variable"
}

resource "local_file" "ansible_inventory" {

 count    = var.web_provision ? 1 : 0
 filename = "${path.module}/for.ini"

 content = templatefile("${path.module}/inventory.tmpl", {
    # For Web
    web_servers = [
        for i in yandex_compute_instance.web : {
            name = i.name
            ip   = i.network_interface[0].nat_ip_address
            #fqdn = i.hostname
            fqdn = "${i.name}.ru-central1.internal"
        }
    ]

    # For Db
    db_servers = [
        for i in yandex_compute_instance.db : {
            name = i.name
            ip   = i.network_interface[0].nat_ip_address
            #fqdn = i.hostname
            fqdn = "${i.name}.ru-central1.internal"
        }
    ]

    # for Storage
    storage_servers = [{  
            name = yandex_compute_instance.storage_vm.name
            ip   = yandex_compute_instance.storage_vm.network_interface[0].nat_ip_address
            #fqdn = yandex_compute_instance.storage_vm.hostname
            fqdn = "${yandex_compute_instance.storage_vm.name}.ru-central1.internal"
        }
    ]

    # for Task-8
    web_servers1 = [
        for i in yandex_compute_instance.web : {
            name = i.name
            fqdn = "${i.name}.ru-central1.internal"
            platform_id = i.platform_id # Добавьте это, если у ресурса есть такой атрибут
            network_interface = [
                {
                    nat_ip_address = i.network_interface[0].nat_ip_address
                }
            ]
        }
    ]
    }
    )
}

resource "terraform_data" "web_hosts_provision" {
    
    count  = var.web_provision == true ? 1 : 0
    depends_on = [local_file.ansible_inventory]

    provisioner "local-exec" {
        command = "eval $(ssh-agent) && cat ~/.ssh/id_rsa_yandex | ssh-add -"
        on_failure = continue
    }

    provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/for.ini ${abspath(path.module)}/test.yml"
        on_failure = continue
        environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    }

    triggers_replace = {
        inventory_content = local_file.ansible_inventory[0].content
        #password_change   = jsonencode({ for k, v in random_password.each : k => v.result })
    }
}
