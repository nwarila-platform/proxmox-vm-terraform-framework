package terraform_plan

import rego.v1

protected_owner_resources contains resource if {
	resource := input.resources[_]
	resource.type == "proxmox_virtual_environment_vm"
	resource.name == "persistent_disk_owner"
}

deny contains msg if {
	count(protected_owner_resources) == 0
	msg := "OPA plan gate must include the persistent-disk owner VM resource"
}

deny contains msg if {
	resource := protected_owner_resources[_]
	object.get(resource.values, "protection", false) != true
	msg := sprintf("%s must protect the persistent-disk owner VM", [resource.address])
}
