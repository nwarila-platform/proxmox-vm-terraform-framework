
output "ansible_hosts" {
  description = "Host metadata and runner-supplied host vars for downstream Ansible inventory."
  value       = local.ansible_hosts
}

output "ansible_inventory" {
  description = "Structured Ansible inventory generated from all_systems[].ansible metadata."
  value       = local.ansible_inventory
}

output "ansible_inventory_yaml" {
  description = "YAML Ansible inventory generated from all_systems[].ansible metadata."
  value       = yamlencode(local.ansible_inventory)
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
