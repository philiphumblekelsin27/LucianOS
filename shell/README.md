# Shell — LucianOS Desktop

## Purpose
Desktop shell, compositor, window manager, and UI framework for LucianOS.

## Stack
- **Language**: Rust (preferred) or C# .NET MAUI
- **Display**: Wayland + wlroots or Mutter
- **UI Framework**: GTK4 + Libadwaita (Rust: gtk-rs)
- **Components**: Taskbar, Start Menu, Snap Layouts, File Manager, Settings

## Structure
- `src/` — Rust source (main.rs, compositor, shell, UI modules)
- `Cargo.toml` — Rust dependencies
- `resources/` — Icons, themes, CSS
- `tests/` — Unit and integration tests

## Responsibilities
- Modern, Windows-like desktop experience
- Multi-window management and snapping
- Keyboard and touchscreen support
- Accessibility (screen reader, high contrast)
- Dark neon theme as default

## Build
```bash
cargo build --release
```

## Team
**Lead**: Shell Lead (assign in CODEOWNERS)
