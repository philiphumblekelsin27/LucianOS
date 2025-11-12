# Tests — QA & Automation

## Purpose
Automated testing, regression suites, fuzzers, and hardware compatibility matrix.

## Stack
- **Unit Tests**: pytest (Python), cargo test (Rust)
- **Integration Tests**: Bash/Python scripts
- **VMs**: QEMU, VirtualBox, VMware
- **Hardware Testing**: Real laptop and desktop targets
- **Fuzzing**: libFuzzer or custom input generators

## Structure
- `unit/` — Unit tests for Python (AI), Rust (shell), C (kernel)
- `integration/` — End-to-end tests (boot, login, app install, update)
- `hardware/` — Hardware compatibility and device tests
- `fuzzers/` — Input fuzzers for IPC, file manager, network
- `matrix.json` — Hardware and VM test matrix definition

## Responsibilities
- Boot and login on QEMU, VirtualBox, and 3+ real machines
- Multi-window behavior, snap layouts, file manager
- Flatpak app install/uninstall/upgrade
- Suspend/resume, crash recovery, reboot
- AI assistant voice and text automations
- Regression detection and blocking

## Run
```bash
# Unit tests
pytest tests/unit/
cargo test -p lucianos-shell

# Integration smoke tests
bash tests/integration/smoke_test.sh

# VM boot test
qemu-system-x86_64 -cdrom ../build/lucianos-0.1.0.iso -m 2G -smp 2
```

## Team
**Lead**: QA & Automation Lead (assign in CODEOWNERS)
