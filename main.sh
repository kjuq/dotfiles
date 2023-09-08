#!/bin/sh

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
XDG_NO_HOME="${XDG_CONFIG_HOME/$HOME\//}"
SCRIPT_XDG="$SCRIPT_DIR/$XDG_NO_HOME"

source $SCRIPT_DIR/targets.sh

backup() {
    TARGET_FILE="$1"
    IS_XDG="$2"

    # Set a source path and a destination path based on the second argument
    if test "$IS_XDG" == "xdg"; then
        SRC="$XDG_CONFIG_HOME/$TARGET_FILE"
        DST="$SCRIPT_XDG/$TARGET_FILE"
        PARENT_DIR="$SCRIPT_XDG/$(dirname "$TARGET_FILE")"
    elif test "$IS_XDG" == ""; then
        SRC="$HOME/$TARGET_FILE"
        DST="$SCRIPT_DIR/$TARGET_FILE"
        PARENT_DIR="$(dirname "$TARGET_FILE")"
    else
        echo "XDG option is invalid."
        echo "Target: $TARGET_FILE"
        exit 1
    fi

    echo "Backing up: $SRC"

    # Create directories including parent ones
    if ! test -d "$PARENT_DIR"; then
        mkdir --parents "$PARENT_DIR"
    fi

    # Copy directory or file
    if test -d "$SRC"; then
        cp -r "$SRC" "$( dirname "$DST" )"
    else
        cp "$SRC" "$DST"
    fi
}

echo "$xdg_files" | while read f
do
    if ! test "$f" == ""; then
        backup "$f" "xdg"
    fi
done

echo "$files" | while read f
do
    if ! test "$f" == ""; then
        backup "$f"
    fi
done





