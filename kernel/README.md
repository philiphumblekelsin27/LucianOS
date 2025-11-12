# Kernel — LucianOS

## Purpose
Maintain Linux kernel configuration, build scripts, and driver modules for LucianOS.

## Structure
- `build_kernel.sh` — Main kernel build automation
- `config/` — Kernel configs (.config) for different hardware profiles
- `patches/` — Custom kernel hardening and feature patches
- `drivers/` — Out-of-tree drivers if needed

## Responsibilities
- Kernel LTS build and hardening (Grsecurity/SELinux/AppArmor)
- UEFI bootloader integration
- TPM2 and Secure Boot support
- Driver compatibility testing

## Build
```bash
bash build_kernel.sh
```

## Team
**Lead**: Kernel / Platform Lead (assign in CODEOWNERS)
