#!/usr/bin/env bash
set -eu

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0})/../; pwd)

git clone https://github.com/elephantrobotics/myCobot.git $SRC_DIR/elephantrobotics-mycobot
