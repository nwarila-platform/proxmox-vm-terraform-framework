# Threat Model

This threat model covers the Proxmox VM Terraform module in this repository. It
focuses on how tracked Terraform code, CI validation, and consumer-supplied
inventory interact with a Proxmox Virtual Environment cluster.

## Scope

What this module guarantees:

- Terraform Core and the Proxmox provider are exact-pinned, with provider
  checksums committed in `terraform/.terraform.lock.hcl`.
- Proxmox API credentials are top-level sensitive variables. Cloud-init username,
  password, and SSH public key inputs are also sensitive and are intended to come
  from GitHub Actions secrets or another secret store, not checked-in tfvars.
- VM definitions are typed through `all_systems`, and optional device blocks are
  rendered only when callers provide them.
- Persistent data disks can be protected by a derived owner VM whose ID is based
  on the workload VM ID plus `persistent_disk_vm_id_offset`.
- Local validation and CI use Terraform's mock-provider support, so tests do not
  require live Proxmox credentials.

## Trust Boundaries

- **Repository to CI runner.** GitHub Actions checks out this repository and runs
  `make ci` with pinned tools and a read-only token for validation.
- **Terraform to provider registry.** `terraform init` downloads `bpg/proxmox`
  and verifies it against the committed dependency lock file.
- **Consumer inventory to module locals.** VM inventory enters through
  `all_systems`; the module normalizes that input into locals before resources
  read it.
- **Deployment runner to Proxmox API.** Real applies require Proxmox endpoint and
  token variables. Token scope, cluster roles, and API audit logging are
  consumer-owned operational controls.
- **Terraform state.** State contains VM IDs, names, network data, and provider
  metadata. Remote backend policy and encryption are owned by the consuming
  deployment root.

## Threats And Mitigations

- **Provider substitution or checksum drift.** Mitigation: exact provider pins
  plus the committed multi-platform lock file make provider changes reviewable.
- **Credential leakage.** Mitigation: sensitive variables are used for API token
  secrets and cloud-init credentials, and local tfvars/state files stay ignored.
- **Accidental persistent-disk deletion.** Mitigation: persistent disks are held
  by a protected owner VM and tested through `persistent_disks.tftest.hcl`.
- **Optional-device schema drift.** Mitigation: optional blocks such as `cdrom`,
  `efi_disk`, and `virtiofs` are represented in the variable schema and covered
  by a mocked plan test.
- **TLS downgrade.** Mitigation: `proxmox_skip_tls_verify` defaults to `false`;
  callers must explicitly opt into skipping verification for lab clusters.

## Out Of Scope

What this module does **not** guarantee:

- It does not create Proxmox pools, storage backends, bridges, VLANs, templates,
  API users, roles, or tokens.
- It does not harden guest operating systems after clone or cloud-init.
- It does not guarantee that referenced datastores, template keys, mappings, or
  network bridges exist in a live cluster.
- It does not own backup policy, snapshot retention, or disaster recovery.
- It does not decide whether the empty OPA policy directory should inherit a
  central package or carry local policies; that is decision-gated separately.

Cross-reference: `SECURITY.md` defines the reporting channel and support scope
for this repository.
