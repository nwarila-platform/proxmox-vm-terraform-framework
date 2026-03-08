# proxmox-vm-terraform-framework

[![Terraform Validator](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/terraform.yaml/badge.svg?branch=PROD)](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/terraform.yaml)
[![Deploy Docs](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/pages.yaml/badge.svg?branch=PROD)](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/pages.yaml)
[![Security Scan](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/security.yaml/badge.svg?branch=PROD)](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/security.yaml)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/blob/PROD/LICENSE)

A structured, production-grade Terraform framework for managing [Proxmox VE](https://www.proxmox.com/en/proxmox-virtual-environment/overview)
infrastructure. Designed for repeatability, safety, and developer velocity — with multi-layer validation,
automated documentation, and full CI/CD integration out of the box.

---

## Features

<div class="grid cards" markdown>

-   :material-shield-check:{ .lg .middle } **Multi-layer security**

    ---

    Every commit is scanned for secrets, infrastructure misconfigurations, and CVEs by
    `gitleaks`, `trivy`, and `checkov` before it can land.

-   :material-terraform:{ .lg .middle } **Terraform-first**

    ---

    Built on the [`bpg/proxmox`](https://registry.terraform.io/providers/bpg/proxmox/latest)
    provider with pinned versions, strict TFLint rules, and automated format enforcement.

-   :material-book-open-variant:{ .lg .middle } **Auto-generated docs**

    ---

    `terraform-docs` regenerates the [Module Reference](TERRAFORM.md) on every commit.
    This site is rebuilt and deployed automatically on every push to `PROD`.

-   :material-robot:{ .lg .middle } **Fully automated**

    ---

    Dependabot keeps dependencies fresh. `release-please` handles versioning and
    [changelogs](changelog.md). No manual release steps.

-   :material-laptop:{ .lg .middle } **Devcontainer-ready**

    ---

    All tooling pre-installed: Terraform, TFLint, Trivy, terraform-docs, and pre-commit.
    Open in VS Code and start working in seconds.

-   :material-check-all:{ .lg .middle } **Conventional Commits**

    ---

    Commit message format is enforced at the hook level. Combined with `release-please`,
    every `feat:` and `fix:` automatically increments the version and updates the changelog.

</div>

---

## Quick start

```bash
git clone git@github.com:nwarila-platform/proxmox-vm-terraform-framework.git
cd proxmox-vm-terraform-framework

# Install pre-commit hooks
pip install pre-commit
pre-commit install --hook-type pre-commit --hook-type pre-push --hook-type commit-msg

# Set credentials
export TF_VAR_proxmox_hostname="your-proxmox-host"
export TF_VAR_proxmox_api_token_id="user@realm!token-name"
export TF_VAR_proxmox_api_token_secret="your-secret"

# Init and validate
cd terraform && terraform init && terraform validate
```

See [Getting Started](getting-started.md) for the full setup guide.

---

## Quality gates

Every commit passes through this stack before merging:

| Stage | Tool | What it checks |
|---|---|---|
| Pre-commit | `gitleaks` | Hardcoded secrets |
| Pre-commit | `trivy` | Infrastructure misconfigs + CVEs |
| Pre-commit | `terraform fmt` | Canonical formatting |
| Pre-commit | `tflint` | Terraform best practices (bpg/proxmox ruleset) |
| Pre-commit | `terraform validate` | Syntax and internal consistency |
| Pre-commit | `markdownlint` | Documentation quality |
| Pre-commit | `yamllint` | YAML correctness |
| Pre-commit | `conventional-pre-commit` | Commit message format |
| CI | Terraform Validator | Format + validate on self-hosted runner |
| CI | CodeQL | SAST — GitHub Actions workflow scanning |
| CI | Trivy | SARIF → GitHub Security tab |
| CI | Checkov | IaC compliance → GitHub Security tab |

---

## Repository

[:fontawesome-brands-github: nwarila-platform/proxmox-vm-terraform-framework](https://github.com/nwarila-platform/proxmox-vm-terraform-framework){ .md-button .md-button--primary }
[Security Report](security.md){ .md-button }
[Module Reference](TERRAFORM.md){ .md-button }
