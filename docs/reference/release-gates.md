# Release Gates

PRs to `main` must pass:

- `make ci` (Terraform fmt/init/validate/test, TFLint, terraform-docs
  diff, Diataxis docs layout, OPA tests, and OPA plan policy)
- Namespace-local reusable IaC security gates (Trivy, Gitleaks, zizmor)
- Namespace-local reusable CodeQL and Scorecard gates

Reusable workflow refs must remain SHA-pinned per the repository contract.
