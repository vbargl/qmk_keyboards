# qmk_keyboards

External keyboard definitions for QMK and Vial.

Currently this repo contains the NuPhy Air60 V2 ANSI keyboard definition:

```text
keyboards/nuphy/air60_v2/ansi
```

Both VIA and Vial keymaps are included. The Air60 V2 firmware has been
validated against the current upstream `qmk/qmk_firmware` `master` commit listed
below, and the keyboard is recognized by both VIA and Vial.

## Target Revisions

This tree is targeted at these upstream firmware revisions:

| Firmware tree | Repository | Commit |
| --- | --- | --- |
| Original NuPhy fork | `https://github.com/nuphy-src/qmk_firmware.git` branch `nuphy-keyboards` | `f1856912d603800eaca227ae2e1c5c8548fdf261` |
| QMK current upstream | `https://github.com/qmk/qmk_firmware.git` | `cf93bbb78fe0bbf994663555de41372c4b5e59fe` |
| Vial QMK | `https://github.com/vial-kb/vial-qmk.git` | `00fc4627cd038ac9b7e9b8bf2b40b50e9e88aecb` |

The keyboard definition started from NuPhy's `nuphy-keyboards` branch. The QMK
commit is the latest upstream `qmk/qmk_firmware` commit this standalone tree was
validated against. The Vial commit is the `vial-kb/vial-qmk` revision used to
build and flash the tested Vial firmware.

## Using Just

The included `Justfile` prepares local firmware trees and symlinks this keyboard
definition into them. It does not copy the keyboard files.

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

## Notes

The Air60 V2 config defines both the older `SD1_*` UART pin names and the newer
`UART_*` pin names. This is intentional: current QMK and Vial QMK use
`UART_TX_PIN`/`UART_RX_PIN`, and without those aliases the UART driver can fall
back to `A9`, which conflicts with the Air60 V2 matrix column used by
Backspace, `\|`, and Enter.

The physical Mac/Win switch selects the active base layer: Mac uses layer `0`
and Windows uses layer `7`.

The VIA firmware has been built against upstream `qmk/qmk_firmware`, flashed,
and recognized by VIA with the included layout definition. The Vial firmware has
also been built and flashed from `vial-qmk`, and the Vial desktop app recognizes
it without an external keyboard definition.

## Validation

These checks were run with `keyboards/nuphy/air60_v2` symlinked into clean
target worktrees:

```sh
make nuphy/air60_v2/ansi:via
make nuphy/air60_v2/ansi:vial
```

The VIA build was flashed and recognized by VIA. The Vial build was also flashed
and recognized by the Vial desktop app.
