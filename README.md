# qmk_keyboards

External keyboard definitions for QMK/Via and/or QMK/Vial.

Keyboard-specific notes and validation details live with the keyboard
definition:

```text
keyboards/<brand>/<product>/<layout>/readme.md
```

## Target Revisions

This tree is targeted at these upstream firmware revisions:

| Firmware tree | Repository | Commit |
| --- | --- | --- |
| Original NuPhy fork | `https://github.com/nuphy-src/qmk_firmware.git` branch `nuphy-keyboards` | `f1856912d603800eaca227ae2e1c5c8548fdf261` |
| QMK current upstream | `https://github.com/qmk/qmk_firmware.git` | `cf93bbb78fe0bbf994663555de41372c4b5e59fe` |
| Vial QMK | `https://github.com/vial-kb/vial-qmk.git` | `00fc4627cd038ac9b7e9b8bf2b40b50e9e88aecb` |

The QMK commit is the current upstream `qmk/qmk_firmware` `master` revision this
tree is targeted at. The Vial commit is the `vial-kb/vial-qmk` revision used for
Vial builds.

## Using Just

The included `Justfile` prepares local firmware trees and symlinks this keyboard
definition into them. It does not copy the keyboard files.

The `Justfile` has defaults for the Air60 V2. To target a different keyboard,
copy `.env.example` to `.env` and override the relevant variables there:

```sh
cp .env.example .env
```

```dotenv
KEYBOARD=nuphy/air60_v2/ansi
```

`KEYBOARD` is the QMK build target in `brand/keyboard/layout` form. The
`Justfile` derives the symlink path from it automatically, so
`nuphy/air60_v2/ansi` is linked as `keyboards/nuphy/air60_v2/ansi` inside the
generated QMK/Vial trees. `.env` is ignored by git.

Prepare both trees:

```sh
just prepare
```

Build VIA firmware:

```sh
just build-via
```

Build Vial firmware:

```sh
just build-vial
```

Flash VIA firmware:

```sh
just flash-via
```

Flash Vial firmware:

```sh
just flash-vial
```

The generated working directories are ignored by git:

```text
qmk_firmware/
qmk_vial/
```

## Manual Setup

For VIA, clone QMK at the target commit and symlink the keyboard directory:

```sh
git clone https://github.com/qmk/qmk_firmware.git qmk_firmware
cd qmk_firmware
git checkout cf93bbb78fe0bbf994663555de41372c4b5e59fe
git submodule update --init --recursive
mkdir -p keyboards/nuphy
ln -s ../../../keyboards/nuphy/air60_v2 keyboards/nuphy/air60_v2
make nuphy/air60_v2/ansi:via
```

For Vial, clone `vial-qmk` at the target commit and use the same symlink
layout:

```sh
git clone https://github.com/vial-kb/vial-qmk.git qmk_vial
cd qmk_vial
git checkout 00fc4627cd038ac9b7e9b8bf2b40b50e9e88aecb
git submodule update --init --recursive
mkdir -p keyboards/nuphy
ln -s ../../../keyboards/nuphy/air60_v2 keyboards/nuphy/air60_v2
make nuphy/air60_v2/ansi:vial
```

Use `:via` in the QMK tree and `:vial` in the Vial QMK tree. The Vial QMK tree
is expected to build this keyboard as `nuphy/air60_v2/ansi:vial`.
