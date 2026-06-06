mock_provider "proxmox" {
  mock_data "proxmox_virtual_environment_vms" {
    defaults = {
      vms = [
        { name = "rocky-template", node_name = "pve01", status = "stopped", tags = ["template"], template = true, vm_id = 9000 }
      ]
    }
  }
}

variables {
  proxmox_hostname         = "10.0.0.10"
  proxmox_api_token_id     = "terraform@pve!automation"
  proxmox_api_token_secret = "secret"

  all_systems = [
    {
      name      = "probe"
      node_name = "pve01"
      pool_id   = "homelab"
      template  = "rocky_linux_8_x64"
      vm_id     = 300
      # Persistent disk first, then a non-persistent OS disk, without explicit interfaces.
      disks = [
        { datastore_id = "local-lvm", file_format = "raw", size = 64, persist_disk = true },
        { datastore_id = "local-lvm", file_format = "raw", size = 8 }
      ]
    }
  ]
}

run "implicit_interfaces_remain_stable_after_persistent_disk_split" {
  command = plan

  assert {
    condition     = proxmox_virtual_environment_vm.virtual_machine["probe"].disk[0].interface == "scsi1"
    error_message = "The non-persistent disk should keep its original derived interface after persistent disks are split out."
  }

  assert {
    condition     = proxmox_virtual_environment_vm.virtual_machine["probe"].disk[1].interface == "scsi0"
    error_message = "The reattached persistent disk should keep the interface assigned before the split."
  }

  assert {
    condition     = proxmox_virtual_environment_vm.persistent_disk_owner["probe"].disk[0].interface == "scsi0"
    error_message = "The owner VM should keep the persistent disk's original derived interface."
  }
}
