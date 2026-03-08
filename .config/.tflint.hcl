# ============================================================================ #
#  TFLint Configuration                                                        #
#  Strict baseline: deterministic TFLint version + full Terraform ruleset      #
# ============================================================================ #

tflint {
  # Pin the TFLint binary used by CI/developers.
  required_version = "= 0.61.0"
}

config {
  # Maximum module-call coverage.
  # Requires `terraform init` before TFLint when remote modules are referenced.
  call_module_type = "all"

  # Never hide failures in CI.
  force = false

  # Keep the full ruleset active; use rule blocks below for exceptions/overrides.
  disabled_by_default = false
}

plugin "terraform" {
  enabled = true
  preset  = "all"
}

# ---------------------------------------------------------------------------- #
#  Core Rules                                                                  #
# ---------------------------------------------------------------------------- #


rule "terraform_module_pinned_source" {
  enabled = true
  style   = "semver"

  # Add extra branch names only if your org actually uses them.
  # These are appended to the built-in defaults; they do not replace them.
  # default_branches = ["trunk"]
}

rule "terraform_module_version" {
  enabled = true
  exact   = true
}

rule "terraform_required_providers" {
  enabled = true
  source  = true
  version = true
}

rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_deprecated_index" {
  enabled = true
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_deprecated_lookup" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_empty_list_equality" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"
}

rule "terraform_required_version" {
  enabled = true
}

rule "terraform_standard_module_structure" {
  enabled = false 
}

rule "terraform_typed_variables" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_unused_required_providers" {
  enabled = true
}

rule "terraform_workspace_remote" {
  enabled = true
}