# Contributing to LucianOS

Thank you for your interest in contributing to LucianOS! We welcome code, documentation, bug reports, and feature requests from the community.

## Getting Started

1. **Fork** the repository on GitHub
2. **Clone** your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/lucianos.git
   cd lucianos
   ```
3. **Create a feature branch**:
   ```bash
   git checkout -b feature/my-feature
   ```

## Development Setup

See [OS-README.md](./OS-README.md) for detailed prerequisites and tooling setup.

## Code Guidelines

- **Rust**: Follow `clippy` and `rustfmt` standards. Run `cargo fmt && cargo clippy --all` before committing.
- **Python**: Use `black` and `flake8`. Run `black . && flake8 .` before committing.
- **Bash**: Use `shellcheck` for script validation.
- **Markdown**: Follow standard Markdown practices (clear headings, code fences with language tags).

## Testing

Before submitting a PR, ensure your changes pass all tests:

```bash
# Unit tests
cargo test -p lucianos-shell
pytest tests/unit/

# Dry-run build
export APPROVE_RELEASE=true
bash ./deploy_all.sh --version 0.1.0 --dry-run
```

## Pull Request Workflow

1. **Make your changes** on your feature branch
2. **Write clear commit messages**:
   ```
   feat: add Start Menu window snapping (Closes #42)
   fix: resolve TPM key unsealing on boot
   docs: update kernel build instructions
   ```
3. **Push to your fork**:
   ```bash
   git push origin feature/my-feature
   ```
4. **Open a Pull Request** on the main repository with a clear description
5. **Wait for CI and code review**:
   - CI must pass (dry-build, linting, tests)
   - At least one CODEOWNERS approval required
   - Address any review feedback

## Code of Conduct

Be respectful and inclusive. We do not tolerate harassment, discrimination, or abusive behavior.

## Areas for Contribution

### High Priority
- **Kernel hardening**: SELinux policies, syscall surface reduction
- **Shell/UI**: Window management, snap layouts, accessibility
- **Installer**: Calamares modules, first-boot experience
- **Testing**: Hardware compatibility, regression tests
- **Documentation**: User guides, developer docs, video tutorials

### Medium Priority
- **App ecosystem**: Flatpak manifests for additional apps
- **AI/Assistant**: Plugins, automation rules, voice improvements
- **Localization**: Translations for shell and installer

### Nice-to-Have
- Website and marketing materials
- Community tools (forums, wikis)
- Third-party app ports (Wine, Proton support)

## Licensing

By contributing to LucianOS, you agree that your contributions will be licensed under:
- **GPLv3** (for core OS and tooling)
- **LucianOS Proprietary License** (for branding, UI themes, AI core — if applicable)

You retain copyright to your work, but you grant us rights to use it under these licenses.

## Reporting Bugs

1. Check existing [Issues](https://github.com/philiphumblekelsin27/lucianos/issues) to avoid duplicates
2. Open a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs. actual behavior
   - System info (hardware, VM, distro)
   - Screenshots or logs if relevant

## Feature Requests

1. Open an issue labeled `enhancement`
2. Describe the feature and why it matters
3. Discuss with the team before implementing

## Security Issues

If you discover a security vulnerability:
- **Do NOT** open a public issue
- **Email** the project lead: humblekelsin271977@gmail.com
- Include: vulnerability description, reproduction steps, potential impact
- We will address it promptly and credit you in the fix

## Questions?

Feel free to:
- Comment on existing issues
- Ask in [Discussions](https://github.com/philiphumblekelsin27/lucianos/discussions) (TBD)
- Email the project lead

---

**Thank you for helping build LucianOS!**
