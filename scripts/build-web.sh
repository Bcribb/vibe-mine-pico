#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WEB_DIR="$PROJECT_ROOT/web"
CART_NAME="vibe_mine.p8"

# Locate the pico8 binary
if [[ -n "${PICO8_PATH:-}" ]]; then
    PICO8="$PICO8_PATH"
elif [[ -x "/Applications/PICO-8.app/Contents/MacOS/pico8" ]]; then
    PICO8="/Applications/PICO-8.app/Contents/MacOS/pico8"
elif command -v pico8 &>/dev/null; then
    PICO8="$(command -v pico8)"
else
    echo "Error: pico8 not found." >&2
    echo "Set PICO8_PATH or add pico8 to your PATH." >&2
    exit 1
fi

mkdir -p "$WEB_DIR"

# PICO-8 doesn't handle spaces in -root_path well (e.g. iCloud Drive paths).
# Work around it with a temporary symlink at a space-free path.
TMPLINK="/tmp/pico8_build_$$"
trap 'rm -f "$TMPLINK"' EXIT
ln -sfn "$PROJECT_ROOT" "$TMPLINK"

echo "Exporting web build with: $PICO8"
"$PICO8" -root_path "$TMPLINK" "$TMPLINK/$CART_NAME" -export "web/index.html"

if [[ -f "$WEB_DIR/index.html" && -f "$WEB_DIR/index.js" ]]; then
    echo "Build complete: $WEB_DIR/index.html + index.js"
else
    echo "Error: export did not produce expected files." >&2
    exit 1
fi
