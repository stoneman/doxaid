#!/usr/bin/env bash
# Build doxaid.app and install it into /Applications.
#
# Replaces the manual Xcode click-through in README.md with a one-shot
# command:
#   ./install.sh
#
# Adding to Login Items still has to be done by hand in System Settings —
# there's no scriptable, App-Store-friendly API for that on modern macOS.
set -euo pipefail

cd "$(dirname "$0")"

SCHEME="doxaid"
CONFIGURATION="${CONFIGURATION:-Debug}"
DERIVED_DATA="$(mktemp -d -t doxaid-build)"
trap 'rm -rf "$DERIVED_DATA"' EXIT

echo "==> Resolving Swift package dependencies"
xcodebuild \
  -project doxaid.xcodeproj \
  -scheme "$SCHEME" \
  -derivedDataPath "$DERIVED_DATA" \
  -resolvePackageDependencies >/dev/null

echo "==> Building $SCHEME ($CONFIGURATION)"
xcodebuild \
  -project doxaid.xcodeproj \
  -scheme "$SCHEME" \
  -configuration "$CONFIGURATION" \
  -derivedDataPath "$DERIVED_DATA" \
  build

APP_PATH="$DERIVED_DATA/Build/Products/$CONFIGURATION/$SCHEME.app"
if [[ ! -d "$APP_PATH" ]]; then
  echo "error: build succeeded but $APP_PATH is missing" >&2
  exit 1
fi

DEST="/Applications/$SCHEME.app"
echo "==> Installing to $DEST"
# Quit any running instance so the replace doesn't fail on a busy bundle.
osascript -e "tell application \"$SCHEME\" to quit" 2>/dev/null || true
# Belt-and-braces: kill anything that ignored the AppleScript quit (e.g.
# a previous build with a different bundle ID, or a stuck process).
pkill -x "$SCHEME" 2>/dev/null || true
rm -rf "$DEST"
cp -R "$APP_PATH" "$DEST"

echo "==> Launching $SCHEME"
open "$DEST"

echo
echo "Done."
echo "First-time setup only — add to launch-at-login via:"
echo "  System Settings -> General -> Login Items -> + -> $DEST"
