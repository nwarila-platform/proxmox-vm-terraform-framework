
output "ansible_hosts" {
  description = "Minimal host metadata for generating downstream Ansible inventory from static cloud-init IPs."
  value = {
    for name, vm in local.virtual_machines : name => {
      ansible_host = try(
        split("/", compact([
          for network_device in coalesce(vm.network_devices, []) :
          network_device.ipv4_address != null ? network_device.ipv4_address : ""
        ])[0])[0],
        null
      )
      node_name = vm.node_name
      vm_id     = vm.vm_id
    }
  }
}

output "persistent_disk_owners" {
  description = "Protected helper VMs that own disks declared with persist_disk=true."
  value = {
    for name, owner in local.persistent_disk_owners : name => {
      name      = owner.name
      node_name = owner.node_name
      vm_id     = owner.vm_id
    }
  }
}
