# Contributing

Contributions should keep the module safe to validate without live Proxmox credentials.

Before opening a pull request:

1. Run `make ci`.
1. Keep Terraform changes under `terraform/`.
1. Update `docs/reference/terraform.md` when inputs, outputs, providers, or resources change.
1. Use Conventional Commits with one of the documented commit types.

Do not commit secrets, local state, generated crash logs, or environment-specific credentials.
