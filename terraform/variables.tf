#region ------ [ Promox Virtual Environment Systems Variable Definitions ] -------------------- #

variable "proxmox_hostname" {
  type        = string
  description = "Proxmox API endpoint, e.g., '10.69.128.49'"
}

variable "proxmox_api_token_id" {
  type        = string
  description = "Proxmox API token ID (format: user@realm!token-name)"
}

variable "proxmox_api_token_secret" {
  type        = string
  sensitive   = true
  description = "Proxmox API token secret string"
}

variable "proxmox_skip_tls_verify" {
  type        = bool
  default     = false
  description = "Skip TLS certificate verification when connecting to the Proxmox API. Defaults to false (secure). Set to true only in lab environments with self-signed certificates."
}

#endregion --- [ Promox Virtual Environment Systems Variable Definitions ] -------------------- #

variable "all_systems" {
  description = ""

  type = list(
    object({

      /* Required Parameters */
      name      = string
      node_name = string
      pool_id   = string
      template  = string
      vm_id     = number

      /*  Optional Parameters */
      acpi = optional(bool, true)
      agent = optional(
        object({
          enabled = optional(bool, false)
          timeout = optional(string, "15m")
          trim    = optional(bool, false)
          type    = optional(string, "virtio")
        })
      )
      amd_sev = optional(
        object({
          allow_smt      = optional(bool)
          kernel_hashes  = optional(bool)
          no_debug       = optional(bool)
          no_key_sharing = optional(bool)
          type           = optional(string)
        })
      )
      audio_device = optional(
        object({
          device  = optional(string, "intel-hda")
          driver  = optional(string, "spice")
          enabled = optional(bool, true)
        })
      )
      bios       = optional(string, "ovmf")
      boot_order = optional(list(string), [])
      cdrom = optional(
        object({
          file_id   = optional(string, "cdrom")
          interface = optional(string, "ide3")
        })
      )
      clone = optional(
        object({
          full = optional(bool)
          # node_name = <! Note: Pulled Automatically From Template !>
          # vm_id     = <! Note: Pulled Automatically From Template !>
          retries = optional(number)
        })
      )
      cpu = optional(
        object({
          affinity = optional(string)
          # architecture = <! Note: Pulled Automatically From Template !>
          cores      = optional(number, 1)
          flags      = optional(list(string))
          hotplugged = optional(number, 0)
          limit      = optional(number, 0)
          numa       = optional(bool, false)
          sockets    = optional(number, 1)
          type       = optional(string, "host")
          units      = optional(number, 1024)
        })
      )
      description = optional(string)
      disks = optional(
        list(
          object({
            aio          = optional(string, "io_uring")
            backup       = optional(bool, true)
            cache        = optional(string, "none")
            datastore_id = optional(string, "nvme-pool")
            discard      = optional(string, "ignore")
            file_format  = optional(string, "qcow2")
            # file_id     = optional(string)
            # import_from = optional(string)
            # interface   = <! Note: Calculated automatically !>
            iothread  = optional(bool, false)
            replicate = optional(bool, true)
            serial    = optional(string)
            size      = optional(number, 8)
            speed     = optional(number)
            ssd       = optional(bool, false)
            # path_in_datastore = optional(string)
          })
        )
      )
      efi_disk = optional(
        object({
          datastore_id = optional(string, "nvme-pool")
          file_format  = optional(string, "raw")
          type         = optional(string, "2m")
        })
      )
      hostpcis = optional(
        list(
          object({
            device   = number
            id       = optional(number)
            mapping  = optional(number)
            mdev     = optional(number)
            pcie     = optional(string)
            rombar   = optional(bool)
            rom_file = optional(string)
            xvga     = optional(bool)
          })
        )
      )
      initialization = optional(
        object({
          datastore_id = optional(string, "nvme-pool")
          dns          = optional(string)
          servers      = optional(list(string))
          interface    = optional(string, "ide2")
          # ip_config = <! Note: Values defined in 'network_devices' !>
          user_account = optional(
            object({
              keys     = optional(string)
              password = optional(string)
              username = optional(string)
            })
          )
        })
      )
      keyboard_layout = optional(string, "en-us")
      kvm_arguments   = optional(string)
      machine         = optional(string, "pc")
      memory = optional(
        object({
          dedicated      = optional(number, 512)
          floating       = optional(number, 0)
          hugepages      = optional(string)
          keep_hugepages = optional(bool, false)
          shared         = optional(number, 0)
        })
      )
      migrate = optional(bool, false)
      # name                = <! Note: See 'Required Parameters' Section !>
      network_devices = optional(
        list(
          object({
            bridge       = optional(string, "vmbr0")
            disconnected = optional(bool, false)
            enabled      = optional(bool, true)
            firewall     = optional(bool, false)
            ipv4_address = optional(string)
            ipv4_gateway = optional(string)
            mac_address  = optional(string)
            model        = optional(string, "virtio")
            mtu          = optional(number)
            queues       = optional(number)
            rate_limit   = optional(number)
            trunks       = optional(string)
            vlan_id      = optional(number)
          })
        )
      )
      # node_name           = <! Note: See 'Required Parameters' Section !>
      numa = optional(
        object({
          cpus      = string
          device    = string
          hostnodes = optional(string)
          memory    = number
          policy    = optional(string)
        })
      )
      on_boot             = optional(bool, true)
      operating_system    = optional(string)
      protection          = optional(bool, false)
      reboot              = optional(bool, false)
      reboot_after_update = optional(bool, true)
      rng = optional(
        object({
          max_bytes = optional(number, 1024)
          period    = optional(number, 1000)
          source    = optional(string, "/dev/urandom")
        })
      )
      scsi_hardware = optional(string, "virtio-scsi-pci")
      serial_devices = optional(
        list(
          object({
            device = optional(string, "socket")
          })
        )
      )
      # smbios = <! Note: Pulled Automatically From Template !>
      started = optional(bool, true)
      startup = optional(
        object({
          order      = optional(number, 1)
          up_delay   = optional(number, 5)
          down_delay = optional(number, 5)
        })
      )
      stop_on_destroy     = optional(bool, false)
      tablet_device       = optional(bool, true)
      tags                = optional(list(string))
      timeout_clone       = optional(number, 1800)
      timeout_create      = optional(number, 1800)
      timeout_migrate     = optional(number, 1800)
      timeout_reboot      = optional(number, 1800)
      timeout_shutdown_vm = optional(number, 1800)
      timeout_start_vm    = optional(number, 1800)
      timeout_stop_vm     = optional(number, 300)
      tpm_state = optional(
        object({
          datastore_id = optional(string, "nvme-pool")
          version      = optional(string, "v2.0")
        })
      )
      usbs = optional(
        list(
          object({
            host    = optional(string, "spice")
            mapping = optional(string, "host")
            usb3    = optional(bool, false)
          })
        )
      )
      vga = optional(
        object({
          memory    = optional(number, 16)
          type      = optional(string, "std")
          clipboard = optional(string, "vnc")
        })
      )
      virtiofs = optional(
        object({
          cache        = optional(string)
          direct_io    = optional(bool)
          expose_acl   = optional(bool)
          expose_xattr = optional(bool)
        })
      )
      watchdog = optional(
        object({
          action  = optional(string, "none")
          enabled = optional(bool, false)
          model   = optional(string, "i6300esb")
        })
      )
    })
  )
}
