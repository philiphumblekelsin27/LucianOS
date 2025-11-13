# LucianOS Quick Start Guide

Get up and running with LucianOS development in 5 minutes.

## 1. Clone the Repo

```bash
git clone https://github.com/philiphumblekelsin27/lucianos.git
cd lucianos
```

## 2. Install Dependencies

### Debian/Ubuntu
```bash
sudo apt-get update
sudo apt-get install -y \
  build-essential git curl wget python3 python3-venv python3-pip \
  rustc cargo flatpak-builder podman buildah packer qemu qemu-utils \
  genisoimage gpg jq libgtk-4-dev libadwaita-1-dev
```

### Fedora
```bash
sudo dnf install -y \
  gcc g++ git curl wget python3 python3-devel \
  rust cargo flatpak-builder podman buildah packer qemu qemu-img \
  genisoimage gnupg jq gtk4-devel libadwaita-devel
```

### macOS (Homebrew)
```bash
brew install --cask qemu
brew install rustup cargo packer buildah podman
```

## 3. Set Up Rust

```bash
curl https://sh.rustup.rs -sSf | sh
rustup default stable
source $HOME/.cargo/env
```

## 4. Set Up Python (for AI core)

```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install --upgrade pip
pip install transformers torch whisper coqui-tts vosk langchain
```

## 5. Run Your First Build (Dry-run)

```bash
export APPROVE_RELEASE=true
bash ./deploy_all.sh --version 0.1.0 --dry-run
```

### What this does:
- Builds kernel (placeholder)
- Builds rootfs (placeholder)
- Builds desktop shell (Rust)
- Builds AI assistant (Python)
- Generates checksums
- Outputs artifacts to `build/`

### Expected Output:
```
[INFO] LucianOS Deployment — Version 0.1.0
[INFO] Dry-run: true
[INFO] Step 1: Build Kernel + RootFS
[INFO] Step 2: Build Desktop Shell & AI
[INFO] Step 3: Generate ISO
[INFO] Step 4: Compute Checksums
[INFO] Step 5: Sign ISO
[INFO] Deployment complete. Artifacts are in: ./build
```

## 6. View Build Artifacts

```bash
ls -lh build/
```

You'll see:
- `lucianos-v0.1.0.iso` — (placeholder ISO for now)
- `sha256sum.txt` — checksums
- `build.log` — full build output

## 7. Explore the Codebase

### Learn about each component:
- `kernel/README.md` — Linux kernel and hardening
- `shell/README.md` — Desktop UI (Rust + GTK4)
- `ai/README.md` — STAR assistant (Python, local LLM)
- `installer/README.md` — Calamares setup
- `packages/README.md` — Flatpak app store
- `ci/README.md` — Build automation
- `tests/README.md` — QA and testing

### Explore the code:
```bash
# Shell (Rust)
cd shell
cargo build
cargo fmt && cargo clippy --all

# AI (Python)
cd ../ai
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt  # (add requirements.txt if needed)
python3 run_assistant.py --build-only
```

## 8. Create Your First Feature Branch

```bash
git checkout -b feature/my-awesome-feature
# Edit files...
git add .
git commit -m "feat: add my awesome feature"
git push origin feature/my-awesome-feature
```

Then open a Pull Request on GitHub. CI will automatically:
- Run a dry-build
- Lint your code
- Upload artifacts for review

## 9. Check CI Status

After you push, go to: `https://github.com/philiphumblekelsin27/lucianos/actions`

You'll see your workflow run. Green ✅ means all checks passed.

## Next Steps

1. Read [OS-README.md](./OS-README.md) for the full project overview
2. Read [CONTRIBUTING.md](./CONTRIBUTING.md) for contribution guidelines
3. Read [LucianOS-Deployment.md](./LucianOS-Deployment.md) for detailed build and release docs
4. Join the team and pick a feature to work on!

## Common Commands

```bash
# Dry-run build (no upload)
export APPROVE_RELEASE=true
bash ./deploy_all.sh --version 0.1.0 --dry-run

# Full build and release (with GPG signing)
export APPROVE_RELEASE=true
bash ./deploy_all.sh --version 0.1.0

# Shell dev
cd shell && cargo build --release && cargo fmt && cargo clippy --all

# AI dev
cd ai && python3 run_assistant.py

# Run tests
pytest tests/unit/
cargo test -p lucianos-shell
```

## Troubleshooting

### "Command not found" errors
Ensure all prerequisites are installed. Run the install commands above for your OS.

### Rust toolchain issues
```bash
rustup update
rustup default stable
```

### Python venv not activating
```bash
# On Linux/macOS:
source venv/bin/activate

# On Windows PowerShell:
venv\Scripts\Activate.ps1

# On Windows CMD:
venv\Scripts\activate.bat
```

### Build fails with "packer not found"
Install Packer from https://www.packer.io/downloads or your package manager.

## Questions?

- Check [CONTRIBUTING.md](./CONTRIBUTING.md) for more info
- Open an [Issue](https://github.com/philiphumblekelsin27/lucianos/issues)
- Ask on [Discussions](https://github.com/philiphumblekelsin27/lucianos/discussions) (TBD)

---

**Happy coding! 🚀**
