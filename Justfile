set shell := ["bash", "-eu", "-o", "pipefail", "-c"]
set dotenv-load := true

qmk_repo := env_var_or_default("QMK_REPO", "https://github.com/qmk/qmk_firmware.git")
qmk_commit := env_var_or_default("QMK_COMMIT", "cf93bbb78fe0bbf994663555de41372c4b5e59fe")

vial_repo := env_var_or_default("VIAL_REPO", "https://github.com/vial-kb/vial-qmk.git")
vial_commit := env_var_or_default("VIAL_COMMIT", "00fc4627cd038ac9b7e9b8bf2b40b50e9e88aecb")

export KEYBOARD := env_var_or_default("KEYBOARD", "nuphy/air60_v2/ansi")

default:
    @just --list

prepare: prepare-qmk prepare-vial

prepare-qmk:
    if [ ! -d qmk_firmware/.git ]; then git clone {{qmk_repo}} qmk_firmware; fi
    cd qmk_firmware && git fetch origin {{qmk_commit}} && git checkout {{qmk_commit}}
    cd qmk_firmware && git submodule update --init --recursive
    keyboard_path="keyboards/${KEYBOARD}"; keyboard_parent_path="$(dirname "$keyboard_path")"; if [ -L "qmk_firmware/$keyboard_parent_path" ]; then rm "qmk_firmware/$keyboard_parent_path"; fi; mkdir -p "qmk_firmware/$keyboard_parent_path"; rm -rf "qmk_firmware/$keyboard_path"; link_target="$(realpath --relative-to="$(dirname "qmk_firmware/$keyboard_path")" "$keyboard_path")"; ln -s "$link_target" "qmk_firmware/$keyboard_path"

prepare-vial:
    if [ ! -d qmk_vial/.git ]; then git clone {{vial_repo}} qmk_vial; fi
    cd qmk_vial && git fetch origin {{vial_commit}} && git checkout {{vial_commit}}
    cd qmk_vial && git submodule update --init --recursive
    keyboard_path="keyboards/${KEYBOARD}"; keyboard_parent_path="$(dirname "$keyboard_path")"; if [ -L "qmk_vial/$keyboard_parent_path" ]; then rm "qmk_vial/$keyboard_parent_path"; fi; mkdir -p "qmk_vial/$keyboard_parent_path"; rm -rf "qmk_vial/$keyboard_path"; link_target="$(realpath --relative-to="$(dirname "qmk_vial/$keyboard_path")" "$keyboard_path")"; ln -s "$link_target" "qmk_vial/$keyboard_path"

build-via: prepare-qmk
    cd qmk_firmware && make "$KEYBOARD:via"

build-vial: prepare-vial
    cd qmk_vial && make "$KEYBOARD:vial"

flash-via: prepare-qmk
    cd qmk_firmware && make "$KEYBOARD:via:flash"

flash-vial: prepare-vial
    cd qmk_vial && make "$KEYBOARD:vial:flash"
