terraform {

  # Specify the required Terraform version
  required_version = "1.14.6"

  # Specify the required providers
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.97.1"
    }
  }

}
