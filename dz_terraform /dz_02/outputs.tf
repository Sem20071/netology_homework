output "info" {
    value = [
        {netology-develop-platform-web ={
            instance_name = yandex_compute_instance.platform.name
            external_ip   = yandex_compute_instance.platform.network_interface.0.ip_address
            fqdn          = yandex_compute_instance.platform.fqdn
          }
        },
        {netology-develop-platform-db ={
            instance_name = yandex_compute_instance.platform-db.name
            external_ip   = yandex_compute_instance.platform-db.network_interface.0.ip_address
            fqdn          = yandex_compute_instance.platform-db.fqdn
          }
        }
    ]
}