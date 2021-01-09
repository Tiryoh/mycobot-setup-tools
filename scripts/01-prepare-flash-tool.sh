#!/usr/bin/env bash
set -eu

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0})/../; pwd)

git clone https://github.com/Tiryoh/docker-esptool.git $SRC_DIR/docker-esptool
cd $SRC_DIR/docker-esptool
docker build -t tiryoh/esptool:3.0 .