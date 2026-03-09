resource "proxmox_virtual_environment_vm" "virtual_machine" {
  for_each = local.virtual_machines

  acpi        = each.value["acpi"]
  bios        = each.value["bios"]
  boot_order  = each.value["boot_order"]
  description = each.value["description"]
  # disk                = <! Note: Is 'dynamic' object located below !>
  # hostpci             = <! Note: Is 'dynamic' object located below !>
  keyboard_layout = each.value["keyboard_layout"]
  kvm_arguments   = each.value["kvm_arguments"]
  machine         = each.value["machine"]
  migrate         = each.value["migrate"]
  name            = each.value["name"]
  # network_device      = <! Note: Is 'dynamic' object located below !>
  node_name           = each.value["node_name"]
  on_boot             = each.value["on_boot"]
  pool_id             = each.value["pool_id"]
  protection          = each.value["protection"]
  reboot              = each.value["reboot"]
  reboot_after_update = each.value["reboot_after_update"]
  scsi_hardware       = each.value["scsi_hardware"]
  # serial_device       = <! Note: Is 'dynamic' object located below !>
  # smbios              = each.value["smbios"]
  started         = each.value["started"]
  stop_on_destroy = each.value["stop_on_destroy"]
  tablet_device   = each.value["tablet_device"]
  tags            = each.value["tags"]
  # template            = <! Note: We never create templates directly !>
  timeout_clone       = each.value["timeout_clone"]
  timeout_create      = each.value["timeout_create"]
  timeout_migrate     = each.value["timeout_migrate"]
  timeout_reboot      = each.value["timeout_reboot"]
  timeout_shutdown_vm = each.value["timeout_shutdown_vm"]
  timeout_start_vm    = each.value["timeout_start_vm"]
  timeout_stop_vm     = each.value["timeout_stop_vm"]
  # usb                 = <! Note: Is 'dynamic' object located below !>
  vm_id = each.value["vm_id"]

  #region ------ [ Conditional Itterative Properties ]--------------------------------------- #

  dynamic "disk" {
    for_each = coalesce(each.value["disks"], [])
    iterator = disk

    content {
      aio          = disk.value["aio"]
      backup       = disk.value["backup"]
      cache        = disk.value["cache"]
      datastore_id = disk.value["datastore_id"]
      discard      = disk.value["discard"]
      file_format  = disk.value["file_format"]
      file_id      = disk.value["file_id"]
      import_from  = disk.value["import_from"]
      interface    = disk.value["interface"]
      iothread     = disk.value["iothread"]
      replicate    = disk.value["replicate"]
      serial       = disk.value["serial"]
      size         = disk.value["size"]
      # speed        = disk.value["speed"]
      ssd = disk.value["ssd"]
    }
  }

  dynamic "hostpci" {
    for_each = coalesce(each.value["hostpcis"], [])
    iterator = hostpci

    content {
      device   = hostpci.value["device"]
      id       = hostpci.value["id"]
      mapping  = hostpci.value["mapping"]
      mdev     = hostpci.value["mdev"]
      pcie     = hostpci.value["pcie"]
      rombar   = hostpci.value["rombar"]
      rom_file = hostpci.value["rom_file"]
      xvga     = hostpci.value["xvga"]
    }
  }

  dynamic "serial_device" {
    for_each = coalesce(each.value["serial_devices"], [])
    iterator = serial_device

    content {
      device = serial_device.value["device"]
    }
  }

  dynamic "usb" {
    for_each = coalesce(each.value["usbs"], [])
    iterator = usb

    content {
      host    = usb.value["host"]
      mapping = usb.value["mapping"]
      usb3    = usb.value["usb3"]
    }
  }

  dynamic "network_device" {
    for_each = coalesce(each.value["network_devices"], [])
    iterator = network_device

    content {
      bridge       = network_device.value["bridge"]
      disconnected = network_device.value["disconnected"]
      enabled      = network_device.value["enabled"]
      firewall     = network_device.value["firewall"]
      mac_address  = network_device.value["mac_address"]
      model        = network_device.value["model"]
      mtu          = network_device.value["mtu"]
      queues       = network_device.value["queues"]
      rate_limit   = network_device.value["rate_limit"]
      vlan_id      = network_device.value["vlan_id"]
      trunks       = network_device.value["trunks"]
    }
  }

  #endregion --- [ Conditional Itterative Properties ]--------------------------------------- #

  #region ------ [ Conditional Block Properties ] ------------------------------------------- #

  dynamic "agent" {
    for_each = each.value["agent"][*]
    iterator = agent

    content {
      enabled = agent.value["enabled"]
      timeout = agent.value["timeout"]
      trim    = agent.value["trim"]
      type    = agent.value["type"]
    }
  }

  dynamic "amd_sev" {
    for_each = each.value["amd_sev"][*]
    iterator = amd_sev

    content {
      allow_smt      = amd_sev.value["allow_smt"]
      kernel_hashes  = amd_sev.value["kernel_hashes"]
      no_debug       = amd_sev.value["no_debug"]
      no_key_sharing = amd_sev.value["no_key_sharing"]
      type           = amd_sev.value["type"]
    }
  }

  dynamic "audio_device" {
    for_each = each.value["audio_device"][*]
    iterator = audio_device

    content {
      device  = audio_device.value["device"]
      driver  = audio_device.value["driver"]
      enabled = audio_device.value["enabled"]
    }
  }

  dynamic "cdrom" {
    for_each = each.value["cdrom"][*]
    iterator = cdrom

    content {
      enabled   = cdrom.value["enabled"]
      file_id   = cdrom.value["file_id"]
      interface = cdrom.value["interface"]
    }
  }

  dynamic "clone" {
    for_each = each.value["clone"][*]
    iterator = clone

    content {
      # datastore_id = clone.value["datastore_id"]
      full      = clone.value["full"]
      node_name = clone.value["node_name"]
      retries   = clone.value["retries"]
      vm_id     = clone.value["vm_id"]
    }
  }

  dynamic "cpu" {
    for_each = each.value["cpu"][*]
    iterator = cpu

    content {
      #affinity     = cpu.value["affinity"]
      #architecture = cpu.value["architecture"]
      cores      = cpu.value["cores"]
      flags      = cpu.value["flags"]
      hotplugged = cpu.value["hotplugged"]
      limit      = cpu.value["limit"]
      numa       = cpu.value["numa"]
      sockets    = cpu.value["sockets"]
      type       = cpu.value["type"]
      units      = cpu.value["units"]
    }
  }

  dynamic "efi_disk" {
    for_each = each.value["efi_disk"][*]
    iterator = efi_disk

    content {
      datastore_id      = efi_disk.value["datastore_id"]
      file_format       = efi_disk.value["file_format"]
      pre_enrolled_keys = efi_disk.value["pre_enrolled_keys"]
      type              = efi_disk.value["type"]
    }
  }

  dynamic "initialization" {
    for_each = each.value["initialization"][*]
    iterator = initialization

    content {
      datastore_id = initialization.value["datastore_id"]
      interface    = initialization.value["interface"]

      dynamic "dns" {
        for_each = (initialization.value["dns"] != null || initialization.value["servers"] != null) ? [1] : []

        content {
          domain  = initialization.value["dns"]
          servers = initialization.value["servers"]
        }
      }

      dynamic "ip_config" {
        for_each = [
          for nd in coalesce(each.value["network_devices"], []) :
          nd if nd["ipv4_address"] != null || nd["ipv4_gateway"] != null
        ]
        iterator = network_device

        content {
          ipv4 {
            address = network_device.value["ipv4_address"]
            gateway = network_device.value["ipv4_gateway"]
          }
        }
      }

      dynamic "user_account" {
        for_each = initialization.value["user_account"][*]
        iterator = user_account

        content {
          keys     = user_account.value["keys"] != null ? toset([user_account.value["keys"]]) : null
          password = user_account.value["password"]
          username = user_account.value["username"]
        }
      }
    }
  }

  dynamic "memory" {
    for_each = each.value["memory"][*]
    iterator = memory

    content {
      dedicated      = memory.value["dedicated"]
      floating       = memory.value["floating"]
      hugepages      = memory.value["hugepages"]
      keep_hugepages = memory.value["keep_hugepages"]
      shared         = memory.value["shared"]
    }
  }

  dynamic "numa" {
    for_each = each.value["numa"][*]
    iterator = numa

    content {
      cpus      = numa.value["cpus"]
      device    = numa.value["device"]
      hostnodes = numa.value["hostnodes"]
      memory    = numa.value["memory"]
      policy    = numa.value["policy"]
    }
  }

  dynamic "operating_system" {
    for_each = each.value["operating_system"][*]
    iterator = operating_system

    content {
      type = operating_system.value
    }
  }

  dynamic "rng" {
    for_each = each.value["rng"][*]
    iterator = rng

    content {
      max_bytes = rng.value["max_bytes"]
      period    = rng.value["period"]
      source    = rng.value["source"]
    }
  }

  dynamic "startup" {
    for_each = each.value["startup"][*]
    iterator = startup

    content {
      down_delay = startup.value["down_delay"]
      order      = startup.value["order"]
      up_delay   = startup.value["up_delay"]
    }
  }

  dynamic "tpm_state" {
    for_each = each.value["tpm_state"][*]
    iterator = tpm_state

    content {
      datastore_id = tpm_state.value["datastore_id"]
      version      = tpm_state.value["version"]
    }
  }

  dynamic "vga" {
    for_each = each.value["vga"][*]
    iterator = vga

    content {
      clipboard = vga.value["clipboard"]
      memory    = vga.value["memory"]
      type      = vga.value["type"]
    }
  }

  dynamic "virtiofs" {
    for_each = each.value["virtiofs"][*]
    iterator = virtiofs

    content {
      cache        = virtiofs.value["cache"]
      direct_io    = virtiofs.value["direct_io"]
      expose_acl   = virtiofs.value["expose_acl"]
      expose_xattr = virtiofs.value["expose_xattr"]
      mapping      = virtiofs.value["mapping"]
    }
  }

  dynamic "watchdog" {
    for_each = each.value["watchdog"][*]
    iterator = watchdog

    content {
      action  = watchdog.value["action"]
      enabled = watchdog.value["enabled"]
      model   = watchdog.value["model"]
    }
  }

  #endregion --- [ Conditional Block Properties ] ------------------------------------------- #

}
