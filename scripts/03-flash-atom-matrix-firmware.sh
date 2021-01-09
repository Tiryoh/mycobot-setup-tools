#!/usr/bin/env bash
set -eu

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0})/../; pwd)

SOFTWARE_VERSION=v1.3
FIRMWARE_NAME="AtomMain2.3"

USB_PORT="/dev/ttyUSB0"

cd $SRC_DIR/elephantrobotics-mycobot/Software/myCobot固件烧录器${SOFTWARE_VERSION}/ino
docker run --rm -it -v $(pwd):/work --device ${USB_PORT}:/dev/ttyUSB0 tiryoh/esptool:3.0 \
    --chip esp32 --port /dev/ttyUSB0 write_flash --flash_mode dio -z  0xe000 boot_app0.bin 0x1000 bootloader_qio_80m.bin 0x10000 ${FIRMWARE_NAME}.ino.bin 0x8000 ${FIRMWARE_NAME}.ino.partitions.bin