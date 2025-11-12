# Packages — Flatpak App Store

## Purpose
Flatpak manifests, app sandboxing policies, and package signing for LucianOS App Store.

## Stack
- **Format**: Flatpak manifests (JSON/YAML)
- **Runtime**: Freedesktop runtime or custom LucianOS runtime
- **Signing**: GPG for repository and app authentication
- **Infrastructure**: Flatpak repository (HTTP/S3 backend)

## Structure
- `app-manifests/` — Individual app Flatpak manifests
  - `org.lucianos.Browser/` — Firefox or Chromium base
  - `org.lucianos.Terminal/` — Terminal emulator
  - `org.lucianos.Editor/` — Text editor (gedit, VSCode)
  - `org.lucianos.MediaPlayer/` — Video/audio playback
  - `org.lucianos.Settings/` — System settings app
- `repository/` — Generated Flatpak repository (built by CI)
- `signing/` — GPG keys and signatures (store in secrets manager, not in repo)

## Responsibilities
- Package 10+ seed apps for MVP
- Sandbox and permission policies
- Reproducible builds via flatpak-builder
- Signed repository for user trust
- Auto-update via Flatpak runtime

## Build
```bash
flatpak-builder --repo=repository build-dir app-manifests/org.lucianos.Browser/org.lucianos.Browser.yml
flatpak build-export repository
```

## Team
**Lead**: App System Lead (assign in CODEOWNERS)
