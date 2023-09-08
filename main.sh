#!/bin/sh

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
XDG_NO_HOME="${XDG_CONFIG_HOME/$HOME\//}"
SCRIPT_XDG="$SCRIPT_DIR/$XDG_NO_HOME"

source $SCRIPT_DIR/targets.sh

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
        cp -r "$SRC" "$( dirname "$DST" )"
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
        cp -r "$SRC" "$( dirname "$DST" )"
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





