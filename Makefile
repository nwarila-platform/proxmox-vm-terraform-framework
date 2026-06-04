PYTHON ?= python3

.PHONY: fmt fmt-check init validate test docs docs-diff graph docs-check tflint opa-test opa-plan version-check ci

# Mutating: rewrites HCL in place. Use locally before committing.
fmt:
	terraform -chdir=terraform fmt -recursive

# Non-mutating: fails if any file would change. Use in CI.
fmt-check:
	terraform -chdir=terraform fmt -check -recursive

init:
	terraform -chdir=terraform init -backend=false -input=false

validate:
	terraform -chdir=terraform validate

test:
	terraform -chdir=terraform test

# Mutating: regenerates the injected block in docs/reference/terraform.md.
docs:
	terraform-docs --config .terraform-docs.yml terraform

# Non-mutating: fails if docs/reference/terraform.md is out of sync with terraform/.
docs-diff:
	terraform-docs --config .terraform-docs.yml --output-check terraform

graph:
	bash tools/render_graphs.sh

docs-check:
	$(PYTHON) tools/check_docs_layout.py

tflint:
	tflint --chdir=terraform

opa-test:
	opa test policies/opa

opa-plan:
	mkdir -p .tmp/opa-plan
	terraform -chdir=terraform test -json -verbose > .tmp/opa-plan/terraform-test.jsonl
	$(PYTHON) tools/build_plan_input.py < .tmp/opa-plan/terraform-test.jsonl | opa eval --fail-defined --format pretty --stdin-input --data policies/opa 'data.terraform_plan.deny[_]'

version-check:
	$(PYTHON) tools/check_terraform_version_pin.py

ci:
	$(MAKE) version-check
	$(MAKE) fmt-check
	$(MAKE) init
	$(MAKE) validate
	$(MAKE) test
	$(MAKE) tflint
	$(MAKE) docs-diff
	$(MAKE) docs-check
	$(MAKE) opa-test
	$(MAKE) opa-plan
