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
      # persist disk FIRST, then a non-persistent OS disk SECOND, NO explicit interfaces
      disks = [
        { datastore_id = "local-lvm", file_format = "raw", size = 64, persist_disk = true },
        { datastore_id = "local-lvm", file_format = "raw", size = 8 }
      ]
    }
  ]
}

run "probe_index_derived_interfaces" {
  command = plan

  # workload VM keeps only the non-persistent disk. What interface does it get?
  assert {
    condition     = proxmox_virtual_environment_vm.virtual_machine["probe"].disk[0].interface == "scsi0"
    error_message = "INDEXPROBE workload non-persistent disk interface = ${proxmox_virtual_environment_vm.virtual_machine["probe"].disk[1].interface}"
  }
}
