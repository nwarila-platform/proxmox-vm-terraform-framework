package terraform_plan

import rego.v1

deny contains msg if {
	resource := input.resources[_]
	resource.type == "proxmox_virtual_environment_vm"
	resource.name == "persistent_disk_owner"
	object.get(resource.values, "protection", false) != true
	msg := sprintf("%s must protect the persistent-disk owner VM", [resource.address])
}
