#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
xhost +SI:localuser:root
sudo xkeysnail ${SCRIPT_DIR}/config.py

