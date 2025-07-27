locals {
    vms_ssh_root_key_file = file("~/.ssh/id_ed25519.pub")
    vms_ssh_root_key = "ubuntu:${local.vms_ssh_root_key_file}"
    vm_metadata = coalesce(var.vm_metadata, { 
      serial-port-enable = 1,
      ssh-keys = local.vms_ssh_root_key
    })
}
