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

      cdrom = {
        enabled   = true
        file_id   = "local:iso/rocky.iso"
        interface = "ide2"
      }

      disks = [
        {
          interface    = "scsi0"
          datastore_id = "local-lvm"
          file_format  = "raw"
          size         = 32
        },
        {
          interface    = "scsi1"
          datastore_id = "local-lvm"
          file_format  = "raw"
          serial       = "persistent-data"
          size         = 128
          persist_disk = true
        }
      ]

      efi_disk = {
        datastore_id      = "local-lvm"
        file_format       = "raw"
        pre_enrolled_keys = true
        type              = "4m"
      }

      network_devices = [
        {
          ipv4_address       = "10.0.10.50"
          ipv4_prefix_length = 24
          ipv4_gateway       = "10.0.10.1"
        }
      ]

      ansible = {
        groups = ["indexers", "servers"]
        host_vars = {
          ansible_user      = "automation"
          wazuh_data_mount  = "/mnt/data"
          wazuh_data_fstype = "xfs"
        }
      }

      virtiofs = {
        cache        = "always"
        direct_io    = false
        expose_acl   = false
        expose_xattr = true
        mapping      = "shared"
      }
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
    condition     = proxmox_virtual_environment_vm.virtual_machine["persistent-case"].cdrom[0].enabled == true
    error_message = "cdrom.enabled should be accepted by the variable schema and rendered into the VM."
  }

  assert {
    condition     = proxmox_virtual_environment_vm.virtual_machine["persistent-case"].efi_disk[0].pre_enrolled_keys == true
    error_message = "efi_disk.pre_enrolled_keys should be accepted by the variable schema and rendered into the VM."
  }

  assert {
    condition     = proxmox_virtual_environment_vm.virtual_machine["persistent-case"].virtiofs[0].mapping == "shared"
    error_message = "virtiofs.mapping should be accepted by the variable schema and rendered into the VM."
  }

  assert {
    condition     = output.ansible_hosts["persistent-case"].ansible_user == "automation"
    error_message = "ansible_hosts should include runner-supplied host vars."
  }

  assert {
    condition     = output.ansible_inventory["indexers"].hosts["persistent-case"].ansible_host == "10.0.10.50"
    error_message = "ansible_inventory should place the host in each configured group."
  }

  assert {
    condition     = strcontains(output.ansible_inventory_yaml, "\"servers\":")
    error_message = "ansible_inventory_yaml should render configured groups."
  }
}
