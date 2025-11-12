# Installer — LucianOS Setup

## Purpose
Customized installer, first-boot experience, and system configuration scripts using Calamares.

## Stack
- **Framework**: Calamares (modular installer)
- **Configuration**: YAML + Python modules
- **Language**: Bash, Python for custom steps

## Structure
- `calamares/` — Calamares config files and modules
- `scripts/` — First-boot, post-install, recovery hooks
- `branding/` — LucianOS installer branding (splash, logo, colors)

## Responsibilities
- UEFI + BIOS boot support
- Disk partitioning and LUKS2 encryption with TPM seal
- User account creation + Windows-like login screen
- Timezone, keyboard, locale selection
- Flatpak repo and system baseline setup
- Easy rollback and recovery entry
- Clear EULA and telemetry opt-out

## Build
```bash
# Calamares config is embedded in rootfs build
# See ../image/build_rootfs.sh for integration
```

## Team
**Lead**: Installer/Imaging Lead (assign in CODEOWNERS)
