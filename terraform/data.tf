data "proxmox_virtual_environment_vms" "rocky_linux_9_disa_stig" {

  filter {
    name   = "name"
    regex  = true
    values = ["^rocky-linux-9-template$"]
  }

  filter {
    name   = "template"
    values = [true]
  }

}
