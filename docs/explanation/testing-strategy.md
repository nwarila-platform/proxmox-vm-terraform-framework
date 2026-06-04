# Testing Strategy

## What The Tests Cover

`terraform test` runs with the Proxmox provider mocked, so the suite exercises
Terraform graph behavior without contacting a live cluster.

- `terraform/tests/persistent_disks.tftest.hcl` verifies that a VM with
  `persist_disk = true` creates one protected persistent-disk owner VM.
- The same test verifies the default owner VM ID derivation from
  `persistent_disk_vm_id_offset`.
- The test asserts that the workload VM retains its OS disk and persistent data
  disk.
- The test populates `cdrom`, `efi_disk`, and `virtiofs` blocks so schema and
  resource rendering stay aligned.
- The test verifies Ansible host and inventory outputs for configured groups and
  host variables.
- `make ci` also runs version-pin checking, formatting, init, validation, TFLint,
  terraform-docs drift detection, documentation layout checks, and the OPA
  target.

## What The Tests Do Not Cover

- They do not apply changes to a live Proxmox cluster.
- They do not prove that referenced templates, datastores, bridges, storage
  mappings, pools, or nodes exist.
- They do not yet cover every optional VM device block.
- They do not test backup, snapshot, or guest OS hardening behavior.
- They do not make the currently empty OPA policy directory substantive.

## Required Expansion

New optional VM blocks should be added to the mocked plan test when introduced.
Validation rules should get negative tests with `expect_failures` so bad input
fails before a live apply.
