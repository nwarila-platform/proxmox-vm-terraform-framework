locals {
  # Define All Available Virtual Machine Images
  vm_templates = {
    "rocky_linux_9_x64" = data.proxmox_virtual_environment_vms.rocky_linux_9_disa_stig.vms[0]
  }
}

locals {
  virtual_machines = {
    for system in var.all_systems : system.name => {

      /* Required Parameters */
      name      = system.name
      node_name = system.node_name
      pool_id   = system.pool_id
      template  = system.template
      vm_id     = system.vm_id

      /* Optional Parameters */
      acpi         = system.acpi
      agent        = system.agent
      amd_sev      = system.amd_sev
      audio_device = system.audio_device
      bios         = system.bios
      boot_order   = system.boot_order
      cdrom        = system.cdrom
      clone = {
        # datastore_id = <! Note No Way To Pull This From Template !>
        full      = try(system.clone.full, null)
        node_name = local.vm_templates[system.template]["node_name"]
        retries   = try(system.clone.retries, null)
        vm_id     = local.vm_templates[system.template]["vm_id"]
      }
      cpu                 = system.cpu
      description         = system.description
      disks               = system.disks
      efi_disk            = system.efi_disk # This probably needs to be a merge?
      hostpcis            = system.hostpcis
      initialization      = system.initialization
      keyboard_layout     = system.keyboard_layout
      kvm_arguments       = system.kvm_arguments
      machine             = system.machine
      memory              = system.memory
      migrate             = system.migrate
      network_devices     = system.network_devices
      numa                = system.numa
      on_boot             = system.on_boot
      operating_system    = system.operating_system
      protection          = system.protection
      reboot              = system.reboot
      reboot_after_update = system.reboot_after_update
      rng                 = system.rng
      scsi_hardware       = system.scsi_hardware
      serial_devices      = system.serial_devices
      # smbios            = coalesce(local.vm_templates[system.operating_system].smbios, null)
      started             = system.started
      startup             = system.startup
      stop_on_destroy     = system.stop_on_destroy
      tablet_device       = system.tablet_device
      tags                = system.tags
      timeout_clone       = system.timeout_clone
      timeout_create      = system.timeout_create
      timeout_migrate     = system.timeout_migrate
      timeout_reboot      = system.timeout_reboot
      timeout_shutdown_vm = system.timeout_shutdown_vm
      timeout_start_vm    = system.timeout_start_vm
      timeout_stop_vm     = system.timeout_stop_vm
      tpm_state           = system.tpm_state
      usbs                = system.usbs
      vga                 = system.vga
      virtiofs            = system.virtiofs
      watchdog            = system.watchdog
    }
  }
}
