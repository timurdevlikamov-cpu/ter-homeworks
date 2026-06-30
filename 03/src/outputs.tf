output "all_my_vms" {
    value = concat(
    [
        # count
        for vm in yandex_compute_instance.web : {
            name = vm.name
            id   = vm.id
            #fqdn = vm.network_interface[0].internal_ip
            fqdn = vm.network_interface[0].ip_address 
        }
    ],
    [
        for vm in yandex_compute_instance.db : {
            name = vm.name
            id   = vm.id
            #fqdn = vm.network_interface[0].internal_ip
            fqdn = vm.network_interface[0].ip_address
        }
    ]
    )
}
