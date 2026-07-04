# NuPhy Air60 V2

*NuPhy Air60 V2 is a standard 64 key keyboard.*
![NuPhy Air60 V2](https://bit.ly/48qfjbS)

* Keyboard Maintainer: [nuphy](https://github.com/nuphy-src)
* Hardware Supported: NuPhy Air60 V2 PCB
* Hardware Availability: Private

## Target Revisions

This standalone keyboard definition started from NuPhy's `nuphy-keyboards`
branch and is targeted at these firmware revisions:

| Firmware tree | Repository | Commit |
| --- | --- | --- |
| Original NuPhy fork | `https://github.com/nuphy-src/qmk_firmware.git` branch `nuphy-keyboards` | `f1856912d603800eaca227ae2e1c5c8548fdf261` |
| QMK current upstream | `https://github.com/qmk/qmk_firmware.git` | `cf93bbb78fe0bbf994663555de41372c4b5e59fe` |
| Vial QMK | `https://github.com/vial-kb/vial-qmk.git` | `00fc4627cd038ac9b7e9b8bf2b40b50e9e88aecb` |

## Build Targets

Default QMK build:

    make nuphy/air60_v2/ansi:default

VIA build against upstream QMK:

    make nuphy/air60_v2/ansi:via

Vial build against `vial-qmk`:

    make nuphy/air60_v2/ansi:vial

Flashing example:

    make nuphy/air60_v2/ansi:default:flash

## Validation

The VIA firmware has been built against upstream `qmk/qmk_firmware`, flashed,
and recognized by VIA with the included layout definition. The Vial firmware has
also been built and flashed from `vial-qmk`, and the Vial desktop app recognizes
it without an external keyboard definition.

The keyboard is recognized by both VIA and Vial.

## Notes

The physical Mac/Win switch selects the active base layer: Mac uses layer `0`
and Windows uses layer `7`.

The config defines both the older `SD1_*` UART pin names and the newer `UART_*`
pin names. This is intentional: current QMK and Vial QMK use
`UART_TX_PIN`/`UART_RX_PIN`, and without those aliases the UART driver can fall
back to `A9`, which conflicts with the Air60 V2 matrix column used by
Backspace, `\|`, and Enter.

See the [build environment setup](https://docs.qmk.fm/#/getting_started_build_tools) and the [make instructions](https://docs.qmk.fm/#/getting_started_make_guide) for more information. Brand new to QMK? Start with our [Complete Newbs Guide](https://docs.qmk.fm/#/newbs).

## Bootloader

Enter the bootloader in one way:

* **Bootmagic reset**: Hold down the key at (0,0) in the matrix (usually the top left key or Escape) and plug in the keyboard
