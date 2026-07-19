# Changelog

## [2.0.0](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/compare/v1.0.1...v2.0.0) (2026-07-19)


### ⚠ BREAKING CHANGES

* user_account removed from initialization block in tfvars. Inject credentials via TF_VAR_proxmox_cloud_init_user_name, TF_VAR_proxmox_cloud_init_user_password, and TF_VAR_proxmox_cloud_init_user_public_key environment variables.

### Features

* add .gitattributes for consistent line endings and language detection ([c541d31](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/c541d319fb1b4d16a36d89cdf5a301a19a6d5f40))
* add reusable IaC security scan caller ([#24](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/24)) ([9b9bbbd](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/9b9bbbde845549e472a155577c752e7ac25d1e88))
* **ci:** adopt pr-validation (contract-and-lint mode) ([#33](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/33)) ([d45628d](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/d45628dc6593da21946c6432b79d272124072414))
* **ci:** graduate to mode: full ([#41](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/41)) ([c7c7a60](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/c7c7a60f46c55e46a635952a7d5bb598da260363))
* **ci:** lint_advisory + bump to 1c92039 + prep renovate.json5 ([#34](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/34)) ([65e25ce](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/65e25ce1de2b62ac1ed218e178d54175d4ce3f5f))
* complete contract scaffold + .gitignore allowlist ([#38](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/38)) ([fee5bf7](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/fee5bf72feb17b8555430adec1cb2b3a3e09664e))
* consume reusable CodeQL workflow ([#31](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/31)) ([46eecea](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/46eecea846d302ec54669a56c1b08151abe315c0))
* contract scaffold + pin bump to ecb7a74 ([#28](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/28)) ([7ab0e66](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/7ab0e6669ce7706116650520eddea0ba82532614))
* enhance network device configuration with optional IPv4 prefix length ([7c6c937](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/7c6c9373ea64cf2bc4ba72eaff33efa9f744d246))
* implement dynamic initialization properties for virtual machines ([af834d1](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/af834d11dce2c8473beb23b188a630e5c3b25d63))
* move cloud-init credentials to top-level sensitive variables ([a578bc3](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/a578bc3dfdaf5d32d96364a029d25d501cb2f4e3))
* onboard NWarila/terraform-template@aeb3d18 (sync only) ([#18](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/18)) ([5a1d217](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/5a1d217b7cc9de220abd7803f6f26edd857bf4df))
* **security:** adopt OpenSSF Scorecard + bump pin to 9d354ff ([#45](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/45)) ([be56de4](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/be56de4295989476f9537450073e08052c4e4839))
* **terraform:** allow persisted disks to attach on separate interface ([ba678c5](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/ba678c55947762ab134a482ab6bf723d9a6df338))
* **terraform:** expose stable VM disk interfaces ([27dad50](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/27dad501da672f3fba60adc7c913fcd88e0ee61b))
* **terraform:** generate ansible inventory outputs ([7d2b0d5](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/7d2b0d5ffabe7f486760a8c66d10d9b1acd72393))
* **terraform:** preserve persistent VM disks ([51a9c37](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/51a9c3718b4d391de976959a0d215e509818b89d))


### Bug Fixes

* **ci:** drop forbidden *_advisory inputs on security caller ([#48](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/48)) ([f3758f0](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/f3758f081ea9d99049e3c1280a357558b941cc9b))
* **contract:** exact tf pins + SHA-pin actions + PR template casing ([#39](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/39)) ([3995446](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/399544676bb6e6f5bb6947d1eb09be43988e1514))
* **contract:** SHA-pin release-please-action ([#40](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/issues/40)) ([fb1eff2](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/fb1eff2aab6e8ca369d7490cfd679cf033c54b4e))
* **terraform:** tolerate unused missing templates ([15f4280](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/15f42807d0e8fd132ab9e71461d47476a6819da9))

## [1.0.1](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/compare/v1.0.0...v1.0.1) (2026-03-09)


### Bug Fixes

- secure TLS default and document proxmox_skip_tls_verify ([fe7cc5f](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/fe7cc5fef13f91df0f2936227014a823224910e8))

## 1.0.0 (2026-03-09)


### Bug Fixes

- correct pip cache path and release-please action ref ([5f2cb69](https://github.com/nwarila-platform/proxmox-vm-terraform-framework/commit/5f2cb697f8d0cb9162c13e5fdc232c3a8bb8d9fa))
