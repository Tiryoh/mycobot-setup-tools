#!/usr/bin/env bash
set -eu

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0})/../; pwd)

cd $SRC_DIR
wget https://github.com/elephantrobotics/myCobot/releases/download/0/myCobot.V1.3.zip
unzip myCobot.V1.3.zip
