# Image — LucianOS

## Purpose
Manage rootfs (root filesystem) generation, image layouts, and package integration for LucianOS ISOs.

## Structure
- `build_rootfs.sh` — Rootfs build and packing automation
- `layouts/` — Filesystem layouts and directory structure templates
- `scripts/` — First-boot, post-install, and setup scripts
- `grub/` — GRUB bootloader configs for UEFI

## Responsibilities
- Base filesystem creation (using Debian/Arch minimal or buildroot)
- Integrate kernel + modules
- Integrate shell, AI, and Flatpak repo
- Generate ISO via packer/genisoimage
- Ensure reproducible, signed builds

## Build
```bash
bash build_rootfs.sh
```

## Team
**Lead**: Installer/Imaging Lead (assign in CODEOWNERS)
