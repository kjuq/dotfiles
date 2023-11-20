#!/bin/bash

# check if XDG_CONFIG_HOME is set
if [ -z "$XDG_CONFIG_HOME" ]; then
    echo "XDG_CONFIG_HOME is not set. Quit."
    exit 1
fi

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
XDG_NO_HOME="${XDG_CONFIG_HOME/$HOME\//}"
SCRIPT_XDG="$SCRIPT_DIR/$XDG_NO_HOME"

source $SCRIPT_DIR/targets.sh

backup() {
    TARGET_FILE="$1"
    IS_XDG="$2"

    # Set a source path and a destination path based on a second argument
    if [ "$IS_XDG" == "xdg" ]; then
        SRC="$XDG_CONFIG_HOME/$TARGET_FILE"
        DST="$SCRIPT_XDG/$TARGET_FILE"
        PARENT_DIR="$SCRIPT_XDG/$(dirname "$TARGET_FILE")"
    elif [ "$IS_XDG" == "" ]; then
        SRC="$HOME/$TARGET_FILE"
        DST="$SCRIPT_DIR/$TARGET_FILE"
        PARENT_DIR="$(dirname "$TARGET_FILE")"
    else
        echo "XDG option is invalid."
        echo "Target: $TARGET_FILE"
        exit 1
    fi

    if [ -L $SRC ]; then
        return 0
    fi

    echo "Backing up: $SRC"

    # Create directories including parent ones
    if ! [ -d "$PARENT_DIR" ]; then
        mkdir --parents "$PARENT_DIR"
    fi

    # Copy directory or file
    if [ -d "$SRC" ]; then
        cp -r "$SRC" "$( dirname "$DST" )"
    else
        cp "$SRC" "$DST"
    fi
}

symlink() {
    TARGET_FILE="$1"
    IS_XDG="$2"

    # Set a source path and a destination path based on a second argument
    if [ "$IS_XDG" == "xdg" ]; then
        SRC="$SCRIPT_XDG/$TARGET_FILE"
        DST="$XDG_CONFIG_HOME/$TARGET_FILE"
        PARENT_DIR="$XDG_CONFIG_HOME/$(dirname "$TARGET_FILE")"
    elif [ "$IS_XDG" == "" ]; then
        SRC="$SCRIPT_DIR/$TARGET_FILE"
        DST="$HOME/$TARGET_FILE"
        PARENT_DIR="$HOME/$(dirname "$TARGET_FILE")"
    else
        echo "XDG option is invalid."
        echo "Target: $TARGET_FILE"
        exit 1
    fi

    echo "Creating Symlink: $SRC"

    # Create directories including parent ones
    if ! [ -d "$PARENT_DIR" ]; then
        mkdir --parents "$PARENT_DIR"
    fi

    # Create a symlink
    # Delete a pre-exist link
    if [ -L "$DST" ]; then
        return 0
    fi
    # Delete a pre-exist dir/file
    if [ -e "$DST" ]; then
        read -p "$DST already exists. Delete it? (y/N) " INPUT
        if [ "$INPUT" == "y" ] || [ "$INPUT" == "Y" ]; then
            if [ -d "$DST" ]; then
                rm -r "$DST"
            elif [ -f "$DST" ]; then
                rm "$DST"
            else
                echo "Unknown Filetype Error: when deleting $DST"
                exit 1
            fi
        else
            return 0
        fi
    fi
    ln --symbolic "$SRC" "$DST"
}

unsymlink() {
    false
    # TODO
}

main() {
    if [ "$1" == "backup" ] || [ "$1" == "b" ]; then
        ACTION="backup"
    elif [ "$1" == "symlink" ] || [ "$1" == "s" ]; then
        ACTION="symlink"
    else
        echo "Unknown or no argument was given. Quit."
        exit 1
    fi

    IFS_BAK=$IFS
    IFS=$'\n'
    for f in $xdg_files; do
        IFS=$IFS_BAK
        if ! [ "$f" == "" ]; then
            if [ "$ACTION" == "backup" ]; then
                backup "$f" "xdg"
            elif [ "$ACTION" == "symlink" ]; then
                symlink "$f" "xdg"
            fi
        fi
    done

    IFS_BAK=$IFS
    IFS=$'\n'
    for f in $files; do
        IFS=$IFS_BAK
        if ! [ "$f" == "" ]; then
            if [ "$ACTION" == "backup" ]; then
                backup "$f"
            elif [ "$ACTION" == "symlink" ]; then
                symlink "$f"
            fi
        fi
    done
}

main $1




