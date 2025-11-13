# LucianOS — Open-source Operating System
**A sovereign OS: stability of Linux, polish of Windows 11, and an extendable AI core — lightweight, secure, and designer-friendly.**

## Quick Overview

LucianOS is a **modern, modular Linux-based operating system** designed for:
- **Personal Users**: Clean, familiar Windows-like interface with privacy-first defaults
- **Developers**: Extensible architecture, open-source core (GPLv3), easy to customize
- **Enterprises**: Hardened security, reproducible builds, transparent supply chain

**Version**: 0.1.0 (MVP)  
**Status**: Active Development  
**License**: Hybrid — GPLv3 (core) + LucianOS Proprietary (branding & AI)

---

## Project Structure

```
lucianos/
├── kernel/                  # Linux kernel config, hardening, drivers
├── image/                   # Rootfs (root filesystem) and ISO building
├── shell/                   # Desktop shell (Rust + GTK4 + Wayland)
├── ai/                      # STAR assistant (local-first AI, voice I/O)
├── installer/               # Calamares installer, first-boot setup
├── packages/                # Flatpak manifests (app store)
├── ci/                      # GitHub Actions, Packer, build automation
├── tests/                   # Unit, integration, and hardware tests
├── docs/                    # Documentation and archived website
├── deploy_all.sh            # Main deployment script (build → sign → release)
├── LucianOS-Deployment.md   # Deployment guide and CI workflow docs
├── .github/
│   ├── workflows/           # GitHub Actions workflows
│   └── CODEOWNERS          # Code review automation
├── LICENSE                  # GPLv3 license (core OS)
├── LucianOS-License.txt    # Proprietary license (branding, AI, UI)
└── README.md               # This file
```

---

## MVP Deliverables

### ✅ Phase 1 (Weeks 1–8)
- [x] Deployment scripts and CI/CD pipeline (`deploy_all.sh`, `.github/workflows/`)
- [x] Project structure and CODEOWNERS setup
- [ ] Bootable ISO (UEFI x86_64) — `lucianos-0.1.0.iso`
- [ ] Desktop Shell v0.1 (Start Menu, Taskbar, Snap Layouts)
- [ ] TPM + LUKS2 encryption in installer
- [ ] Flatpak repo with 5+ seed apps
- [ ] Local-first STAR AI assistant
- [ ] Comprehensive test matrix (QEMU, VirtualBox, real hardware)

### Future Phases
- OTA (Over-The-Air) delta updates
- Wine/Proton app compatibility layer
- Native Android app support (phase 3)
- Copilot-style AI integration (phase 3+)

---

## Tech Stack at a Glance

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **Kernel** | Linux LTS + custom hardening | Core OS engine |
| **Init** | systemd | System service management |
| **Display** | Wayland + wlroots | Modern display protocol |
| **Shell** | Rust + GTK4 + Libadwaita | Desktop UI (Windows-like) |
| **AI Core** | Python + local LLM (LLAMA.cpp, Ollama) | Voice and text assistant |
| **Apps** | Flatpak + sandboxing | Secure app ecosystem |
| **Security** | SELinux, TPM2, LUKS2, Secure Boot | Hardened defaults |
| **Installer** | Calamares | User-friendly setup |
| **CI/CD** | GitHub Actions + Packer + Buildah | Automated, reproducible builds |

---

## Getting Started

### Prerequisites
Install required tools on your development machine:

```bash
# Debian/Ubuntu
sudo apt-get install -y \
  build-essential git curl wget python3 python3-venv python3-pip \
  rustc cargo flatpak-builder podman buildah packer qemu qemu-utils \
  genisoimage gpg jq libgtk-4-dev libadwaita-1-dev

# Fedora
sudo dnf install -y \
  gcc g++ git curl wget python3 python3-devel \
  rust cargo flatpak-builder podman buildah packer qemu qemu-img \
  genisoimage gnupg jq gtk4-devel libadwaita-devel
```

### Set up Rust
```bash
curl https://sh.rustup.rs -sSf | sh
rustup default stable
```

### Set up Python (for AI core)
```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install transformers torch whisper coqui-tts vosk langchain
```

### Build the OS (Dry-run)
```bash
export APPROVE_RELEASE=true
bash ./deploy_all.sh --version 0.1.0 --dry-run
```

This runs all build steps without uploading. Outputs appear in `build/`.

### Full Deployment
```bash
export APPROVE_RELEASE=true
bash ./deploy_all.sh --version 0.1.0
```

Signs and publishes the release to GitHub.

---

## Development Workflow

### 1. Branch and PR
```bash
git checkout -b feature/my-feature
# Make your changes
git add .
git commit -m "feat: add my feature"
git push origin feature/my-feature
```

Create a Pull Request. CI will:
- Run a dry-build
- Lint code (black, clippy, prettier)
- Upload artifacts for review

### 2. Code Review
- At least one CODEOWNERS approval required (see `.github/CODEOWNERS`)
- CI must pass (no red X)
- Artifacts reviewed by team leads

### 3. Merge & Release
Merge to `main` → CI runs full deployment → ISO published to GitHub Releases

---

## File Locations & Responsibilities

| Directory | Owner | Task |
|-----------|-------|------|
| `kernel/` | Kernel Lead | Build and harden Linux kernel |
| `image/` | Imaging Lead | Generate rootfs and ISO |
| `shell/` | Shell Lead | Desktop UI and window management |
| `ai/` | AI Lead | STAR assistant, local LLM, voice I/O |
| `installer/` | Installer Lead | Calamares config, first-boot setup |
| `packages/` | App System Lead | Flatpak apps and sandboxing |
| `ci/` | CI Lead | GitHub Actions, Packer, signing |
| `tests/` | QA Lead | Automated testing and validation |

---

## Documentation

- **[LucianOS-Deployment.md](./LucianOS-Deployment.md)** — How to build, sign, and deploy the OS
- **[docs/](./docs/)** — User guides, developer docs, design system
- **[docs/archived-site/](./docs/archived-site/)** — Original Next.js website (archived)

---

## Security & Privacy

- **Encryption**: Full disk LUKS2 + TPM-sealed keys
- **Boot Security**: Secure Boot, signed kernel modules
- **Sandboxing**: Flatpak app isolation with strict policies
- **Telemetry**: Opt-in only, no tracking by default
- **AI Data**: Local-first, all user data encrypted in home directory

---

## Contributing

We welcome contributions from the community!

1. **Fork** this repository
2. **Read** [CONTRIBUTING.md](./CONTRIBUTING.md) (if available)
3. **Create a feature branch** and make your changes
4. **Test locally** (run `./deploy_all.sh --dry-run`)
5. **Submit a PR** with a clear description

---

## License

- **Core OS** (kernel, build scripts, tooling): [GPLv3](./LICENSE)
- **Branding, UI, AI Core**: [LucianOS Proprietary License](./LucianOS-License.txt)
- **Third-party**: Respect upstream licenses (Linux, systemd, GTK, Flatpak, etc.)

---

## Support & Community

- **Issues**: Report bugs and request features on [GitHub Issues](https://github.com/philiphumblekelsin27/lucianos/issues)
- **Discussions**: Join community chat (TBD: Discord/Matrix/Forum)
- **Documentation**: See [docs/](./docs/)

---

## Roadmap

### MVP (Q4 2025)
- ✅ Project scaffolding and CI/CD
- 🚧 Kernel and rootfs builds
- 🚧 Desktop shell (GTK4)
- 🚧 STAR AI assistant (local)
- 🚧 Installer and first-boot UX
- 🚧 Flatpak app store

### Phase 2 (2026)
- OTA updates and delta patches
- Extended hardware support (ARM, RISC-V)
- Wine/Proton app compatibility

### Phase 3 (2027+)
- Android app runtime
- AI copilot improvements
- Enterprise features (MDM, deployment tools)

---

## Acknowledgments

LucianOS is built on the shoulders of giants:
- [Linux](https://www.kernel.org/) — OS kernel
- [systemd](https://www.freedesktop.org/wiki/Software/systemd/) — Init system
- [GTK](https://www.gtk.org/) + [Libadwaita](https://gnome.pages.gitlab.gnome.org/libadwaita/) — Desktop UI
- [Flatpak](https://flatpak.org/) — App sandboxing
- [Wayland](https://wayland.freedesktop.org/) — Display protocol
- [Calamares](https://calamares.io/) — Installer framework
- [HuggingFace](https://huggingface.co/) — AI/ML models

---

## Contact

**Project Lead**: Philip Humble Kelsin Lucian (Carlineil)  
**Email**: humblekelsin271977@gmail.com

---

**Made with ❤️ for a better, more sovereign computing experience.**

Last updated: November 12, 2025
