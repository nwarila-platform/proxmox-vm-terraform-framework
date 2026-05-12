mock_provider "proxmox" {
  mock_data "proxmox_virtual_environment_vms" {
    defaults = {
      vms = [
        {
          name      = "rocky-template"
          node_name = "pve01"
          status    = "stopped"
          tags      = ["template"]
          template  = true
          vm_id     = 9000
        }
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
      name      = "persistent-case"
      node_name = "pve01"
      pool_id   = "homelab"
      template  = "rocky_linux_8_x64"
      vm_id     = 200

      disks = [
        {
          interface    = "scsi0"
          datastore_id = "local-lvm"
          file_format  = "raw"
          size         = 32
        },
        {
          interface        = "scsi1"
          attach_interface = "scsi4"
          datastore_id     = "local-lvm"
          file_format      = "raw"
          serial           = "persistent-data"
          size             = 128
          persist_disk     = true
        }
      ]
    }
  ]
}

run "persistent_disk_creates_protected_owner_vm" {
  command = plan

  assert {
    condition     = length(proxmox_virtual_environment_vm.persistent_disk_owner) == 1
    error_message = "persist_disk=true should create one protected owner VM."
  }

  assert {
    condition     = output.persistent_disk_owners["persistent-case"].vm_id == 10200
    error_message = "owner VM ID should default to workload vm_id plus persistent_disk_vm_id_offset."
  }

  assert {
    condition     = proxmox_virtual_environment_vm.persistent_disk_owner["persistent-case"].started == false
    error_message = "persistent disk owner VM should not be started."
  }

  assert {
    condition     = proxmox_virtual_environment_vm.persistent_disk_owner["persistent-case"].protection == true
    error_message = "persistent disk owner VM should be protected in Proxmox."
  }

  assert {
    condition     = length(proxmox_virtual_environment_vm.virtual_machine["persistent-case"].disk) == 2
    error_message = "workload VM should keep the OS disk and attach the persistent data disk."
  }

  assert {
    condition     = proxmox_virtual_environment_vm.persistent_disk_owner["persistent-case"].disk[0].interface == "scsi1"
    error_message = "owner VM should keep the persistent disk on its owner interface."
  }

  assert {
    condition     = proxmox_virtual_environment_vm.virtual_machine["persistent-case"].disk[1].interface == "scsi4"
    error_message = "workload VM should attach the persistent disk on attach_interface when set."
  }
}
