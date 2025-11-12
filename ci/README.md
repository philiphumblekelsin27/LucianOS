# CI — Build Automation & Infrastructure

## Purpose
GitHub Actions workflows, build pipelines, image generation configs, and release automation.

## Stack
- **CI/CD**: GitHub Actions
- **Image Building**: Packer + QEMU/Buildah
- **Signing**: GPG
- **Artifact Upload**: gh CLI, rclone, or awscli

## Structure
- `workflows/` — GitHub Actions YAML workflows
  - `deploy.yml` — Main deploy pipeline (kernel → ISO → release)
  - `lint.yml` — Code quality and linting
  - `test.yml` — Integration and smoke tests
- `packer/` — Packer templates for ISO generation
- `scripts/` — Helper scripts for signing, uploading, OTA updates

## Responsibilities
- Reproducible kernel and rootfs builds
- Automated ISO generation and signing
- Run test matrix (QEMU, VirtualBox, real hardware)
- Publish releases and manage artifact feeds
- OTA update orchestration

## Build
All builds are triggered via `deploy_all.sh` → CI workflows.

## Team
**Lead**: CI/DevOps Lead (assign in CODEOWNERS)
