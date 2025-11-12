#!/usr/bin/env bash
# --------------------------------------------------------
# LucianOS Deployment Script — MVP
# Author: Philip Humble Kelsin Lucian (Carlineil)
# Purpose: Build, sign, and deploy LucianOS ISO + Flatpak repo
# --------------------------------------------------------
set -euo pipefail

# -------------------
# CONFIG & ENV VARS
# -------------------
APPROVE_RELEASE="${APPROVE_RELEASE:-false}"
DRY_RUN=false
SKIP_CHECKS=false
VERSION=""
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$ROOT_DIR/build"
ISO_NAME=""
REPO_OWNER="philiphumblekelsin27"
REPO_NAME="lucianos"

# -------------------
# HELPERS
# -------------------
usage() {
    cat << EOF
Usage: $0 [options]

Options:
  --version <x.y.z>     Set release version (required)
  --dry-run             Run script without uploading/publishing
    --approve             Confirm release (APPROVE_RELEASE=true must be set)
    --skip-checks         Skip environment checks (safe for local dry-runs)
  -h, --help            Show this help message
EOF
}

log() { echo "[INFO] $*"; }
error() { echo "[ERROR] $*" >&2; exit 1; }

check_env() {
    command -v gh >/dev/null 2>&1 || error "gh CLI not found"
    command -v gpg >/dev/null 2>&1 || error "gpg not found"
    command -v qemu-img >/dev/null 2>&1 || error "qemu-img not found"
    command -v packer >/dev/null 2>&1 || error "packer not found"
    command -v buildah >/dev/null 2>&1 || error "buildah not found"
    command -v jq >/dev/null 2>&1 || error "jq not found"
}

# -------------------
# PARSE ARGUMENTS
# -------------------
while [[ $# -gt 0 ]]; do
    case $1 in
        --version)
            VERSION="$2"
            shift 2
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --skip-checks)
            SKIP_CHECKS=true
            shift
            ;;
        --approve)
            APPROVE_RELEASE=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            error "Unknown argument: $1"
            ;;
    esac
done

[[ -z "$VERSION" ]] && error "Version is required. Use --version <x.y.z>"

log "LucianOS Deployment — Version $VERSION"
log "Dry-run: $DRY_RUN"
log "Approve: $APPROVE_RELEASE"
log "Skip checks: $SKIP_CHECKS"

if [[ "$SKIP_CHECKS" != true ]]; then
    check_env
else
    log "SKIP_CHECKS=true — skipping environment dependency checks"
fi

ISO_NAME="lucianos-v${VERSION}.iso"
SHA_FILE="sha256sum.txt"
BUILD_LOG="build.log"

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# -------------------
# BUILD STEPS
# -------------------
log "Step 1: Build Kernel + RootFS"
if ! $DRY_RUN; then
    if [[ -x "$ROOT_DIR/kernel/build_kernel.sh" ]]; then
        bash "$ROOT_DIR/kernel/build_kernel.sh" 2>&1 | tee -a "$BUILD_LOG"
    else
        log "Kernel build script not found or not executable: $ROOT_DIR/kernel/build_kernel.sh — skipping (placeholder)"
    fi
    if [[ -x "$ROOT_DIR/image/build_rootfs.sh" ]]; then
        bash "$ROOT_DIR/image/build_rootfs.sh" 2>&1 | tee -a "$BUILD_LOG"
    else
        log "Rootfs build script not found or not executable: $ROOT_DIR/image/build_rootfs.sh — skipping (placeholder)"
    fi
else
    log "Dry-run: Skipping kernel/rootfs build"
fi

log "Step 2: Build Desktop Shell & AI"
if ! $DRY_RUN; then
    if [[ -d "$ROOT_DIR/shell" ]]; then
        pushd "$ROOT_DIR/shell" >/dev/null
        if command -v cargo >/dev/null 2>&1; then
            cargo build --release 2>&1 | tee -a "$BUILD_LOG"
        else
            log "cargo not found — skipping shell build (placeholder)"
        fi
        popd >/dev/null
    else
        log "shell directory not found — skipping"
    fi

    if [[ -d "$ROOT_DIR/ai" ]]; then
        pushd "$ROOT_DIR/ai" >/dev/null
        if command -v python3 >/dev/null 2>&1; then
            python3 run_assistant.py --build-only 2>&1 | tee -a "$BUILD_LOG" || log "AI build script returned non-zero (placeholder)"
        else
            log "python3 not found — skipping AI build (placeholder)"
        fi
        popd >/dev/null
    else
        log "ai directory not found — skipping"
    fi
else
    log "Dry-run: Skipping shell & AI build"
fi

log "Step 3: Generate ISO"
if ! $DRY_RUN; then
    if [[ -f "$ROOT_DIR/ci/packer.json" ]]; then
        packer build "$ROOT_DIR/ci/packer.json" 2>&1 | tee -a "$BUILD_LOG"
    else
        log "packer.json not found at $ROOT_DIR/ci/packer.json — skipping (placeholder ISO creation)"
        # placeholder: touch an empty ISO name so subsequent steps work in dry runs
        if [[ ! -f "$ISO_NAME" ]]; then
            log "Creating placeholder ISO file: $ISO_NAME"
            dd if=/dev/zero of="$ISO_NAME" bs=1K count=1024 2>/dev/null || fallocate -l 1M "$ISO_NAME" 2>/dev/null || touch "$ISO_NAME"
        fi
    fi
else
    log "Dry-run: Skipping ISO generation"
    # ensure placeholder exists for dry-run outputs
    if [[ ! -f "$ISO_NAME" ]]; then
        touch "$ISO_NAME"
    fi
fi

log "Step 4: Compute Checksums"
if [[ -f "$ISO_NAME" ]]; then
    sha256sum "$ISO_NAME" > "$SHA_FILE"
else
    log "ISO $ISO_NAME not found; creating empty checksum file"
    echo "" > "$SHA_FILE"
fi

# -------------------
# SIGN ISO
# -------------------
log "Step 5: Sign ISO"
if ! $DRY_RUN; then
    if [[ -f "$ISO_NAME" ]]; then
        gpg --batch --yes --detach-sign -a "$ISO_NAME"
    else
        log "ISO not present to sign: $ISO_NAME"
    fi
else
    log "Dry-run: Skipping GPG signing"
fi

# -------------------
# UPLOAD / RELEASE
# -------------------
if [[ "$APPROVE_RELEASE" != true ]]; then
    log "Release approval missing — skipping upload. Set APPROVE_RELEASE=true to publish."
    exit 0
fi

log "Step 6: Upload to GitHub Releases"
if ! $DRY_RUN; then
    if [[ -f "$ISO_NAME" ]]; then
        gh release create "v$VERSION" "$ISO_NAME" "${ISO_NAME}.asc" "$SHA_FILE" \
            --repo "$REPO_OWNER/$REPO_NAME" \
            --title "LucianOS $VERSION MVP Release" \
            --notes "MVP release of LucianOS. Hybrid license applied."
    else
        error "ISO not found: $ISO_NAME"
    fi
else
    log "Dry-run: Skipping upload to GitHub Releases"
fi

log "Deployment complete. Artifacts are in: $BUILD_DIR"
exit 0
