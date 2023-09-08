#!/bin/sh

xdg_files="
atcoder-cli-nodejs/config.json
atcoder-cli-nodejs/cpp
alacritty/alacritty.yml
brewfile/Brewfile
fish/config.fish
git/config
git/ignore
karabiner/assets
karabiner/karabiner.json
kitty/kitty.conf
lazygit/config.yml
nvim/ftplugin
nvim/init.lua
nvim/lua
pycodestyle
tmux/tmux.conf
wezterm/wezterm.lua
xkeysnail
xremap
"

files="
.mackup
.mackup.cfg
.scripts
.ssh/config
Library/Preferences/atcoder-cli-nodejs/config.json
Library/Preferences/atcoder-cli-nodejs/cpp
Library/Preferences/clangd/config.yaml
Library/Preferences/com.colliderli.iina.plist
Library/Preferences/com.hegenberg.BetterTouchTool.plist
Library/Preferences/com.raycast.macos.plist
Library/Application Support/Code/User/settings.json
"

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
XDG_NO_HOME="${XDG_CONFIG_HOME/$HOME\//}"
SCRIPT_XDG="$SCRIPT_DIR/$XDG_NO_HOME"

make_parent_dir() {
    TARGET_FILE="$1"

    PARENT_DIR="$(dirname "$TARGET_FILE")"

    if ! test -d "$PARENT_DIR"; then
        # echo "Making Directories: $PARENT_DIR"
        mkdir --parents "$PARENT_DIR"
    fi
}

make_parent_dir_xdg() {
    TARGET_FILE="$1"

    PARENT_DIR="$SCRIPT_XDG/$(dirname "$TARGET_FILE")"

    if ! test -d "$PARENT_DIR"; then
        # echo "Making Directories: $PARENT_DIR"
        mkdir --parents "$PARENT_DIR"
    fi
}

backup() {
    TARGET_FILE="$1"

    make_parent_dir "$TARGET_FILE"

    SRC="$HOME/$TARGET_FILE"
    DST="$SCRIPT_DIR/$TARGET_FILE"
    echo "Backing up: $SRC"

    if test -d "$SRC"; then
        cp -r "$SRC" "$DST"
    else
        cp "$SRC" "$DST"
    fi
}

backup_xdg() {
    TARGET_FILE="$1"

    make_parent_dir_xdg "$TARGET_FILE"

    SRC="$XDG_CONFIG_HOME/$TARGET_FILE"
    DST="$SCRIPT_XDG/$TARGET_FILE"
    echo "Backing up: $SRC"

    if test -d "$SRC"; then
        cp -r "$SRC" "$DST"
    else
        cp "$SRC" "$DST"
    fi
}

echo "$xdg_files" | while read f
do
    if ! test "$f" == ""; then
        backup_xdg "$f"
    fi
done

echo "$files" | while read f
do
    if ! test "$f" == ""; then
        backup "$f"
    fi
done





