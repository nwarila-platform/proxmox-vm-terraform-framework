package terraform_plan

test_persistent_owner_must_be_protected if {
	result := deny with input as {"resources": [{
		"address": "proxmox_virtual_environment_vm.persistent_disk_owner[\"case\"]",
		"type": "proxmox_virtual_environment_vm",
		"name": "persistent_disk_owner",
		"values": {"protection": false, "started": false},
	}]}
	"proxmox_virtual_environment_vm.persistent_disk_owner[\"case\"] must protect the persistent-disk owner VM" in result
}

test_unprotected_regular_vm_allowed if {
	result := deny with input as {"resources": [
		{
			"address": "proxmox_virtual_environment_vm.persistent_disk_owner[\"case\"]",
			"type": "proxmox_virtual_environment_vm",
			"name": "persistent_disk_owner",
			"values": {"protection": true, "started": false},
		},
		{
			"address": "proxmox_virtual_environment_vm.virtual_machine[\"case\"]",
			"type": "proxmox_virtual_environment_vm",
			"name": "virtual_machine",
			"values": {"protection": false, "started": true},
		},
	]}
	count(result) == 0
}

test_empty_plan_is_denied if {
	result := deny with input as {"resources": []}
	"OPA plan gate must include the persistent-disk owner VM resource" in result
}
