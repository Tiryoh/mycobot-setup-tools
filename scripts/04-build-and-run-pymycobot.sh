#!/usr/bin/env bash
set -eu

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0})/../; pwd)

USB_PORT="/dev/ttyUSB0"

source $SRC_DIR/patch/pymycobot.sh
fix_pymycobot

cd $SRC_DIR
docker build -t tiryoh/python-mycobot .
docker run --rm -it --device ${USB_PORT}:${USB_PORT} tiryoh/python-mycobot
