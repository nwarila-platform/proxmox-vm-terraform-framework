# proxmox-vm-terraform-framework

<!-- Badges -->
[![Terraform Validator](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/terraform.yaml/badge.svg?branch=main)](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/terraform.yaml)
[![Deploy Docs](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/pages.yaml/badge.svg?branch=main)](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/pages.yaml)
[![Security Scan](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/security.yaml/badge.svg?branch=main)](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/actions/workflows/security.yaml)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.14.x-7B42BC?logo=terraform)](https://www.terraform.io/)
[![Provider: bpg/proxmox](https://img.shields.io/badge/Provider-bpg%2Fproxmox-orange)](https://registry.terraform.io/providers/bpg/proxmox/latest)
[![Docs](https://img.shields.io/badge/docs-GitHub%20Pages-blue?logo=github)](https://nwarila-platform.github.io/proxmox-vm-terraform-framework/)

A structured, production-grade Terraform framework for managing [Proxmox VE](https://www.proxmox.com/en/proxmox-virtual-environment/overview) infrastructure. Designed for repeatability, safety, and developer velocity — with multi-layer validation, automated documentation, and full CI/CD integration out of the box.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Developer Workflow](#developer-workflow)
- [CI/CD Pipeline](#cicd-pipeline)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [Security](#security)
- [License](#license)

---

## Overview

This framework provides a standardized foundation for Proxmox infrastructure-as-code. Rather than ad-hoc scripts or one-off configurations, it enforces consistent formatting, validated inputs, and automated safety checks at every stage of the development lifecycle — from local commit to CI pipeline.

**Key goals:**

- **Safety first** — secret detection, security scanning, and format validation block bad commits before they land
- **Consistent developer experience** — identical toolchain via devcontainer, pre-commit hooks, and VSCode tasks
- **Automated quality** — CI validates every push; documentation auto-generates on commit
- **Professional grade** — conventional commits, semantic versioning, and automated changelogs

---

## Features

| Category | Tools |
|---|---|
| Formatting | `terraform fmt`, `markdownlint`, `yamllint`, `.editorconfig` |
| Linting | `tflint` (with bpg/proxmox ruleset) |
| Security | `trivy` (HIGH/CRITICAL misconfigs + CVEs), `gitleaks` (secret detection) |
| Documentation | `terraform-docs` (auto-generated on commit) |
| Commit quality | Conventional Commits enforced via `conventional-pre-commit` |
| CI/CD | GitHub Actions (cross-platform: Linux bash + Windows PowerShell) |
| Dependency mgmt | Dependabot (GitHub Actions + Terraform providers, daily) |
| Dev environment | Devcontainer (Ubuntu 24.04, all tools pre-installed) |

---

## Prerequisites

| Tool | Version | Purpose |
|---|---|---|
| [Terraform](https://developer.hashicorp.com/terraform/install) | `= 1.14.6` | Infrastructure provisioning |
| [TFLint](https://github.com/terraform-linters/tflint) | `= 0.61.0` | Terraform linting |
| [Trivy](https://github.com/aquasecurity/trivy) | latest | Security scanning |
| [terraform-docs](https://terraform-docs.io/) | `>= 0.19.0` | Documentation generation |
| [pre-commit](https://pre-commit.com/) | `>= 4.0.0` | Git hook management |
| [gitleaks](https://github.com/gitleaks/gitleaks) | `= 8.24.0` | Secret detection |

> **Tip:** Use the included [devcontainer](.devcontainer/) to get all tools pre-installed automatically.

---

## Getting Started

### Option A — Devcontainer (recommended)

Open in VSCode and select **Reopen in Container** when prompted. All required tools are pre-installed.

### Option B — Local setup

**1. Clone the repository**

```bash
git clone git@github.com:nwarila-platform/proxmox-vm-terraform-framework.git
cd proxmox-vm-terraform-framework
```

**2. Install pre-commit hooks**

```bash
pip install pre-commit
pre-commit install --hook-type pre-commit --hook-type pre-push --hook-type commit-msg
```

**3. Set Proxmox credentials**

```bash
export TF_VAR_proxmox_hostname="your-proxmox-host"
export TF_VAR_proxmox_api_token_id="your-token-id"
export TF_VAR_proxmox_api_token_secret="your-token-secret"
```

**4. Initialize and validate**

```bash
cd terraform
terraform init
terraform validate
```

---

## Project Structure

```text
proxmox-vm-terraform-framework/
├── .config/                    # Linter & tool configurations
│   ├── .markdownlint.json      # Markdown lint rules
│   ├── .terraform-docs.yml     # terraform-docs output config
│   ├── .tflint.hcl             # TFLint rules (bpg/proxmox ruleset)
│   └── .yamllint.yml           # YAML lint rules
├── .devcontainer/              # VSCode devcontainer definition
├── .github/
│   ├── actions/
│   │   ├── terraform-bash/     # Composite action (Linux)
│   │   └── terraform-powershell/ # Composite action (Windows)
│   ├── ISSUE_TEMPLATE/         # Bug report & feature request templates
│   ├── workflows/
│   │   ├── terraform.yaml      # Terraform validation pipeline
│   │   ├── release-please.yaml # Automated releases & changelog
│   │   └── codeql.yaml         # SAST security scanning
│   ├── CODEOWNERS
│   ├── dependabot.yml
│   └── pull_request_template.md
├── .vscode/                    # VSCode workspace settings & tasks
├── docs/
│   └── TERRAFORM.md            # Auto-generated by terraform-docs
├── examples/                   # Usage examples
├── terraform/                  # Core Terraform configuration
│   ├── backend.tf
│   ├── data.tf
│   ├── locals.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── resources.tf
│   ├── variables.tf
│   └── versions.tf
├── .editorconfig
├── .gitignore
├── .pre-commit.config.yaml
├── CHANGELOG.md
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── LICENSE
├── SECURITY.md
└── SUPPORT.md
```

---

## Developer Workflow

All quality gates run automatically via pre-commit hooks on every commit and push. To run them manually:

```bash
# Run all hooks against all files
pre-commit run --all-files

# Run a specific hook
pre-commit run terraform_fmt --all-files
pre-commit run gitleaks --all-files
```

### VSCode Tasks

The `.vscode/tasks.json` defines a **Full Validation** task (default build task) that chains:

1. `terraform fmt --check`
2. `terraform init`
3. `terraform validate`
4. `tflint`
5. `trivy` security scan

Run it with `Ctrl+Shift+B`.

---

## CI/CD Pipeline

### Terraform Validator (`terraform.yaml`)

Triggers on push to `main` when `.tf` files or the workflow itself change. Runs on self-hosted runners (supports both Linux and Windows).

| Step | Action |
|---|---|
| Checkout | `actions/checkout` (pinned SHA, no credentials persisted) |
| Format check | `terraform fmt -check -diff -recursive` |
| Init | `terraform init -backend=false` |
| Validate | `terraform validate` |

### Release Please (`release-please.yaml`)

Triggers on push to `main`. Parses [Conventional Commits](https://www.conventionalcommits.org/) to:

- Auto-bump semantic version
- Generate and maintain `CHANGELOG.md`
- Create GitHub releases with release notes

### CodeQL (`codeql.yaml`)

Weekly SAST scan + triggered on every push to `main`. Scans for security vulnerabilities and code quality issues.

---

## Configuration

### Terraform Provider

The framework uses the [`bpg/proxmox`](https://registry.terraform.io/providers/bpg/proxmox/latest) provider. Authentication is API-token based:

| Variable | Description |
|---|---|
| `proxmox_hostname` | Proxmox VE host (FQDN or IP) |
| `proxmox_api_token_id` | API token ID (`user@realm!token-name`) |
| `proxmox_api_token_secret` | API token secret UUID |

> See `docs/TERRAFORM.md` for the full auto-generated variable and output reference.

### Tool Versions

All tool versions are pinned. To update:

- **Terraform / provider**: edit `terraform/versions.tf`
- **Pre-commit hooks**: edit `.pre-commit.config.yaml`, then run `pre-commit autoupdate`
- **GitHub Actions**: managed automatically by Dependabot

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines. All commits must follow [Conventional Commits](https://www.conventionalcommits.org/) format — enforced by pre-commit hooks.

Allowed commit types: `feat`, `fix`, `ci`, `docs`, `refactor`, `test`, `chore`, `security`

---

## Security

To report a vulnerability, see [SECURITY.md](SECURITY.md). Do not open a public issue.

---

## License

[MIT](LICENSE) — Copyright 2025 NWarila
