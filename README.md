## Introduction

An app which displays a layout map of the currently active layer on my Ergodox EZ keyboard.

## Usage

Build `doxaid.app` and install it into `/Applications`:

```sh
./install.sh
```

Re-run `./install.sh` any time you want to pick up new changes; it just
replaces the bundle in place.

### One-time setup: launch at login

After the first install, add it as a login item:

- `System Settings` → `General` → `Login Items` → `+` → select
  `/Applications/doxaid.app`

The entry references the path, so subsequent rebuilds are picked up
automatically — no need to re-add it.

### Manual build (alternative)

1. Open in Xcode
1. In the `File` menu, select `Packages` → `Resolve Package Versions`
1. In the `Product` menu, select `Build For` → `Running`
1. In the `Product` menu, select `Show Build Folder in Finder`
1. In the finder window, copy `Products/Debug/doxaid.app` in to `Applications`
