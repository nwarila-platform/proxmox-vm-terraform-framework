# Invariants

Non-negotiable rules for this module. Violating one of these is a breaking
change at minimum.

- Terraform Core and the Proxmox provider MUST remain exact-pinned.
- `terraform/.terraform.lock.hcl` MUST be committed with checksums for the
  supported contributor and CI platforms.
- Proxmox API token secrets and cloud-init credentials MUST remain sensitive
  variables and MUST NOT be accepted through checked-in tfvars.
- `proxmox_skip_tls_verify` MUST default to `false`.
- Persistent disks with `persist_disk = true` MUST be attached to a protected
  owner VM instead of being left ownerless.
- The owner VM ID derivation MUST stay deterministic:
  `workload vm_id + persistent_disk_vm_id_offset`.
- Optional VM device blocks read by `resources.tf` MUST exist in the
  `all_systems` variable schema.
- Ansible inventory outputs MUST remain keyed by VM name and configured group.
- Generated Terraform docs MUST pass `make docs-diff`.
- Local state, `.terraform/`, tfvars with real values, and credentials MUST stay
  untracked.
