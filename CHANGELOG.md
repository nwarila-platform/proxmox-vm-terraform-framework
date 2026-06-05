# Changelog

## [2.0.0](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/compare/v1.0.1...v2.0.0) (2026-06-05)


### ⚠ BREAKING CHANGES

* user_account removed from initialization block in tfvars. Inject credentials via TF_VAR_proxmox_cloud_init_user_name, TF_VAR_proxmox_cloud_init_user_password, and TF_VAR_proxmox_cloud_init_user_public_key environment variables.

### Features

* add .gitattributes for consistent line endings and language detection ([fc3957d](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/fc3957da6145bd9300ad6422dc3f60553d0aa7e9))
* add reusable IaC security scan caller ([#24](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/24)) ([fbf8843](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/fbf88432362e2f93be6513c1743dc474ad5c9447))
* **ci:** adopt pr-validation (contract-and-lint mode) ([#33](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/33)) ([5e90b4c](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/5e90b4c04a97c6a73becce83e2c5c156dc4dcd4f))
* **ci:** graduate to mode: full ([#41](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/41)) ([ab9895f](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/ab9895f7c8a7b8906850e2b4af6f72c760e02b4e))
* **ci:** lint_advisory + bump to 1c92039 + prep renovate.json5 ([#34](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/34)) ([cbf7d39](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/cbf7d39366f1c8112346a52035d717b78cb29a46))
* complete contract scaffold + .gitignore allowlist ([#38](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/38)) ([7615220](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/7615220fcdedfa1fee8f715ed5d3b54b68826e94))
* consume reusable CodeQL workflow ([#31](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/31)) ([e1b8fa1](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/e1b8fa178a5b0ca0dbef5a8012005e0bb4312c0c))
* contract scaffold + pin bump to ecb7a74 ([#28](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/28)) ([f483c79](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/f483c7979f3ad0e52030bc5437fb97f14409ee4e))
* enhance network device configuration with optional IPv4 prefix length ([cb2532d](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/cb2532d7962738dd6e663e10bbcd4a5dec0927d7))
* implement dynamic initialization properties for virtual machines ([04b447b](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/04b447b232e8db5a7798b798de33050436724055))
* move cloud-init credentials to top-level sensitive variables ([0d6dddb](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/0d6dddb13ad31306d162cf08551260e12f745cd4))
* onboard NWarila/terraform-template@aeb3d18 (sync only) ([#18](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/18)) ([b6327e4](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/b6327e4aceb3786ddad31a570b278ec8d72493eb))
* **security:** adopt OpenSSF Scorecard + bump pin to 9d354ff ([#45](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/45)) ([81c208f](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/81c208f57d0675c2aa979f60311663925b36a8c5))
* **terraform:** allow persisted disks to attach on separate interface ([23b8290](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/23b829017a52b0b2e8577f9a1003775bbc2b339d))
* **terraform:** expose stable VM disk interfaces ([9008fdb](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/9008fdb5ba51d233233fd4bdeb522ee053658c61))
* **terraform:** generate ansible inventory outputs ([532cd17](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/532cd178958d5c931eb493bf899861739095a0a6))
* **terraform:** preserve persistent VM disks ([8b803bd](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/8b803bd14477ee9f9604993c6913ed67eca95299))


### Bug Fixes

* **ci:** drop forbidden *_advisory inputs on security caller ([#48](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/48)) ([a9b3062](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/a9b30627829e53c3a71061969d56a90a90284544))
* **contract:** exact tf pins + SHA-pin actions + PR template casing ([#39](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/39)) ([2c068f8](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/2c068f8c4cc7a98fdf5db0f56c97fbc99bddaa46))
* **contract:** SHA-pin release-please-action ([#40](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/40)) ([fbea0de](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/fbea0ded8c2909ba8bae56a466655487e13f2761))
* **terraform:** tolerate unused missing templates ([3136609](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/3136609f4f59d8cb30b42c8607acad7f7b61e2a5))

## [1.0.1](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/compare/v1.0.0...v1.0.1) (2026-03-09)


### Bug Fixes

- secure TLS default and document proxmox_skip_tls_verify ([fe7cc5f](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/fe7cc5fef13f91df0f2936227014a823224910e8))

## 1.0.0 (2026-03-09)


### Bug Fixes

- correct pip cache path and release-please action ref ([5f2cb69](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/5f2cb697f8d0cb9162c13e5fdc232c3a8bb8d9fa))
