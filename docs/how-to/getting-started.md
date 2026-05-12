# Getting Started

## Prerequisites

| Tool | Version | Install |
|---|---|---|
| Terraform | `= 1.14.6` | [developer.hashicorp.com](https://developer.hashicorp.com/terraform/install) |
| TFLint | `= 0.61.0` | [github.com/terraform-linters/tflint](https://github.com/terraform-linters/tflint/releases) |
| Trivy | latest | [aquasecurity.github.io/trivy](https://aquasecurity.github.io/trivy/latest/getting-started/installation/) |
| terraform-docs | `>= 0.19.0` | [terraform-docs.io](https://terraform-docs.io/user-guide/installation/) |
| pre-commit | `>= 4.0.0` | [pre-commit.com](https://pre-commit.com/#install) |

!!! tip "Use the devcontainer"
    All tools are pre-installed in the devcontainer. Open in VS Code and select
    **Reopen in Container** to skip all manual setup.

---

## Option A — Devcontainer

1. Install [VS Code](https://code.visualstudio.com/) and the
   [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2. Clone the repository and open it in VS Code
3. When prompted, select **Reopen in Container**
4. All tools are installed and pre-commit hooks are registered automatically

---

## Option B — Local setup

### 1. Clone the repository

```bash
git clone git@github.com:nwarila-platform/proxmox-vm-terraform-framework.git
cd proxmox-vm-terraform-framework
```

### 2. Install pre-commit hooks

```bash
pip install pre-commit
pre-commit install --hook-type pre-commit --hook-type pre-push --hook-type commit-msg
```

Verify the install:

```bash
pre-commit run --all-files
```

### 3. Set Proxmox credentials

!!! warning "Never commit credentials"
    Credentials belong in environment variables or a secrets manager, not in `terraform.tfvars`
    or any committed file. The `.gitignore` excludes `*.tfvars` by default.

```bash
export TF_VAR_proxmox_hostname="10.0.0.10"
export TF_VAR_proxmox_api_token_id="terraform@pve!automation"
export TF_VAR_proxmox_api_token_secret="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

### 4. Initialize Terraform

```bash
cd terraform
terraform init
terraform validate
```

---

## Preserving data disks across VM rebuilds

Set `persist_disk = true` on any disk that should survive replacement of the
workload VM. The framework creates a protected, stopped owner VM for those
disks and attaches them back to the workload VM by `path_in_datastore`.

```hcl
disks = [
  {
    interface    = "scsi0"
    size         = 32
    datastore_id = "local-lvm"
    file_format  = "raw"
  },
  {
    interface    = "scsi1"
    size         = 128
    datastore_id = "local-lvm"
    file_format  = "raw"
    serial       = "example-data"
    persist_disk = true
  }
]
```

Persistent owner VM IDs default to `vm_id + persistent_disk_vm_id_offset`
(`10000`). Override `persistent_disk_vm_id` on a system when that derived ID
would collide with another VM.

---

## VS Code tasks

The workspace includes a **Full Validation** task (`Ctrl+Shift+B`) that chains:

1. `terraform fmt --check`
2. `terraform init`
3. `terraform validate`
4. `tflint`
5. `trivy` security scan

Run individual tasks via `Ctrl+Shift+P` → **Tasks: Run Task**.

---

## Making changes

All commits must follow [Conventional Commits](https://www.conventionalcommits.org/) format.
The pre-commit hook enforces this automatically.

```bash
# Good
git commit -m "feat: add VM clone timeout configuration"
git commit -m "fix: correct UEFI disk datastore default"
git commit -m "docs: update variable descriptions"

# Bad — will be rejected
git commit -m "updated stuff"
git commit -m "WIP"
```

**Allowed types:** `feat`, `fix`, `ci`, `docs`, `refactor`, `test`, `chore`, `security`

---

## Running security scans locally

```bash
# Secrets
pre-commit run gitleaks --all-files

# Infrastructure misconfigurations and CVEs
pre-commit run terraform_trivy --all-files

# All hooks
pre-commit run --all-files
```
