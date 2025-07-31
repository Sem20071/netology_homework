resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = [for vm in yandex_compute_instance.web_vms[*] : {
      name       = vm.name
      public_ip = vm.network_interface[0].nat_ip_address
      fqdn       = "${vm.fqdn}"
    }],
    dbservers = [for vm in values(yandex_compute_instance.db_vms) : {
      name       = vm.name
      public_ip = vm.network_interface[0].nat_ip_address
      fqdn       = "${vm.fqdn}"
    }],
    stservers = { #yandex_compute_instance.storage
      name       = yandex_compute_instance.storage.name
      public_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn       = "${yandex_compute_instance.storage.fqdn}"
     }
   })
   filename = "${abspath(path.module)}/hosts.ini"
}
