# LucianOS Deployment Guide — Hybrid MVP

## Overview
This document describes how to build, sign, and deploy LucianOS using the provided `deploy_all.sh` script.

### Purpose
Make it easy for developers and CI to produce reproducible ISO artifacts, sign them, and publish releases while preserving the LucianOS hybrid-license model (GPLv3 core + proprietary branding/AI).

---

## Prerequisites
- Bash shell (bash >= 4.0)
- CLI tools: `gh`, `gpg`, `qemu-img`, `packer`, `buildah`, `jq`
- Rust toolchain (for shell build)
- Python 3.11+ (for AI/assistant)
- Local GPG agent configured (or GPG_PRIVATE_KEY exported into CI secrets)
- `APPROVE_RELEASE` set to `true` for a full release (safety guard)

---

## Files added by this workflow
- `deploy_all.sh` — main deployment script with dry-run and approve safety.
- `.github/workflows/deploy.yml` — CI workflow to run dry-run and optional full deployment.
- `LICENSE` — GPLv3 for core components.
- `LucianOS-License.txt` — Proprietary license for branding & AI.
- `.github/CODEOWNERS` — default reviewers / owners file.

---

## Usage

### 1) Dry-run build (recommended first step)
This runs all build steps but does not sign or upload artifacts.

```powershell
# from repo root (Windows PowerShell shown)
$env:APPROVE_RELEASE = "true"
bash ./deploy_all.sh --version 0.1.0 --dry-run
```

Outcomes:
- `build/build.log` (captured output)
- `build/sha256sum.txt`
- placeholder ISO produced for verification

### 2) Full deployment
When you and QA have verified dry-run outputs, perform a full deployment.

```powershell
# ensure secrets configured: GITHUB_TOKEN, GPG_PRIVATE_KEY (in CI) or local gpg agent
$env:APPROVE_RELEASE = "true"
bash ./deploy_all.sh --version 0.1.0
```

What it does:
- Builds kernel, rootfs, shell, and AI (where build scripts exist)
- Generates an ISO (via `packer` or placeholder)
- Computes `sha256sum.txt`
- Signs the ISO with `gpg` (detached ASCII signature)
- Creates a GitHub release and uploads artifacts

### 3) Artifacts layout
```
lucianos-v0.1.0/
├── lucianos-v0.1.0.iso
├── lucianos-v0.1.0.iso.asc
├── sha256sum.txt
└── build.log
```

---

## CI / Automation (high-level)
Add the `.github/workflows/deploy.yml` workflow. It:
- Runs a dry-run on every PR and push to `deploy/hub` and `main`.
- If `APPROVE_RELEASE=true` is set in the workflow_dispatch or as an environment secret, performs a full deployment and publishes the GitHub Release.
- Uploads build artifacts for review whether or not the release is published.

**Secrets to configure in the repo**:
- `GPG_PRIVATE_KEY` (for release signing in CI)
- `GITHUB_TOKEN` (default Actions token works for uploads, but you can use a personal access token if required)

---

## Safety & Process
- Dry-run first for every PR.
- PRs that change release scripts or packer config require at least one approval from `.github/CODEOWNERS` and a successful dry-run artifact upload.
- Publishing a release requires `APPROVE_RELEASE=true` and presence of signing key in CI secrets.

---

## Next steps (recommended)
1. Place `deploy_all.sh` and `LucianOS-Deployment.md` at repo root.
2. Create branch `deploy/hub`, commit these files and `.github/workflows/deploy.yml`, open PR.
3. Configure repository secrets: `GPG_PRIVATE_KEY`, `GITHUB_TOKEN`.
4. Run a workflow_dispatch dry-run to verify artifacts.
5. After QA approves, enable full deploy (set `APPROVE_RELEASE=true`) and run again.

---

## Notes
- The `deploy_all.sh` includes safe placeholders when sub-build scripts are missing (so you can test the pipeline early). Replace placeholders with your real build scripts in `kernel/`, `image/`, `shell/`, and `ai/` as they become available.
- For OTA/delta updates (phase 2), we recommend using ostree or bsdiff-based delta publishing. The current MVP uses full-image uploads.

---

## Licensing
- Core OS modules (kernel configs, packaging, build scripts) — GPLv3 (see `LICENSE`).
- Branding, UI themes, icons, and AI/STAR core — LucianOS Proprietary (see `LucianOS-License.txt`).
