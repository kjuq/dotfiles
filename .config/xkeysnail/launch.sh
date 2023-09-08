#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
xhost +SI:localuser:xkeysnail
sudo -u xkeysnail xkeysnail ${SCRIPT_DIR}/config.py
