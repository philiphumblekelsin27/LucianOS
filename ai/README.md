# AI — LucianOS STAR Assistant

## Purpose
Local-first AI assistant (STAR), speech recognition, text-to-speech, and automation engine.

## Stack
- **Language**: Python 3.11+
- **ML Framework**: Transformers (HuggingFace), LLAMA.cpp, or Ollama for local models
- **Speech I/O**: Vosk (STT), Coqui.ai or Mimic3 (TTS)
- **Automation**: LangChain, Rasa, or custom Python router
- **Storage**: SQLite3 (encrypted) for user data and preferences

## Structure
- `core/` — Main assistant service (daemon, API, plugins)
- `models/` — Local model configurations and adapters
- `plugins/` — App control, note taking, scheduling, system automation
- `voice/` — STT/TTS orchestration
- `tests/` — Unit tests and automation tests
- `run_assistant.py` — Main entry point

## Responsibilities
- Local-first: all user data encrypted in home dir
- REST socket at `/run/lucianos/ai.sock` for IPC
- Voice and text input handling
- Pre-defined automations (open app, create note, schedule)
- Optional remote API adapter (disabled by default, privacy-first)

## Build
```bash
python3 -m venv venv
source venv/bin/activate
pip install transformers torch whisper coqui-tts vosk langchain
python3 run_assistant.py
```

## Team
**Lead**: AI/Assistant Lead (assign in CODEOWNERS)

## LucianOS Live ISO (Lightweight GUI OS)

A companion lightweight, bootable OS build is included for quick testing in VMs.
This produces a Debian-based live ISO with a lightweight graphical shell (Openbox + LightDM),
autologin for a "fast-boot" desktop, basic apps and full OS functions: file manager, terminal,
audio, partitioning tools, network manager, and a simple guided installer to write LucianOS to disk.

Quick build (on Debian/Ubuntu host):
1. Install prerequisites:
   sudo apt update && sudo apt install -y live-build debootstrap squashfs-tools xorriso wget
2. From the LucianOS repo root:
   chmod +x build_iso.sh
   sudo ./build_iso.sh
3. The generated ISO will be at ./live-build/binary.hybrid.iso — boot it in QEMU, VirtualBox, or write to USB.

What the live image includes
- Lightweight GUI (Openbox) with panel (tint2) and autostart for network/audio applets.
- File manager (pcmanfm), terminal (lxterminal), browser (firefox-esr).
- Partition tools (gparted), disk utilities (gdisk), and a simple guided installer (debootstrap + grub)
  available on the desktop to install LucianOS to a target disk.
- SSH server available in the live session for remote debugging (optional).

Notes:
- The builder uses Debian live-build to create a small, bootable ISO (BIOS+UEFI).
- Customize packages in live-build/package-lists/lucianos.list.chroot.
- Hooks under live-build/hooks/ modify the live system (creates user `luciano` with autologin,
  places installer at /usr/local/bin/install-lucianos.sh and a desktop launcher).
- After booting the live ISO, run "Install LucianOS" from the desktop to install to a local disk.

## Preview on Kali Linux (quick)

Summary: On Kali (Debian‑based) you can build the live ISO with the included build_iso.sh or boot an existing ISO with QEMU/VirtualBox.

Prerequisites (Kali host):
sudo apt update
sudo apt install -y live-build debootstrap squashfs-tools xorriso qemu-system-x86 qemu-utils

Build the ISO:
cd /path/to/LucianOS
chmod +x build_iso.sh
sudo ./build_iso.sh
# Result: live-build/binary.hybrid.iso

Boot the ISO in QEMU (fast preview):
# 2GB RAM, 2 CPUs, enable KVM if available
qemu-system-x86_64 -m 2048 -smp 2 -cdrom live-build/binary.hybrid.iso -boot d -enable-kvm

Boot the ISO without KVM:
qemu-system-x86_64 -m 2048 -smp 2 -cdrom live-build/binary.hybrid.iso -boot d

Test in VirtualBox:
- Create new VM (Linux → Debian 64-bit), attach binary.hybrid.iso to the optical drive, enable EFI if desired, start VM.
- Use the desktop "Install LucianOS" icon or run sudo /usr/local/bin/install-lucianos.sh inside the live session to install to disk.

Run the installer manually in the live session:
1. Open a terminal in the live desktop (user: luciano / password: luciano).
2. Become root: sudo -i
3. Launch installer: /usr/local/bin/install-lucianos.sh
4. Follow prompts (WARNING: installer will overwrite the chosen disk).

If you already have an ISO and only want to preview:
qemu-system-x86_64 -m 2048 -smp 2 -cdrom /path/to/binary.hybrid.iso -enable-kvm

Troubleshooting and tips
- If live-build tools are missing in Kali repo, install them on a Debian/Ubuntu host or enable appropriate Kali repos.
- If QEMU reports missing KVM, remove -enable-kvm or enable virtualization in your BIOS/VM host.
- Live user: luciano / luciano (autologin enabled). Use sudo for privileged operations.
- For production installers consider replacing the simple debootstrap installer with Calamares or the Debian installer.
