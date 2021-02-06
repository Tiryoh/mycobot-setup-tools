#!/usr/bin/env bash
set -eu

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0})/../; pwd)


download_atom_main2p3 () {
    cd $SRC_DIR/downloads
    wget https://github.com/elephantrobotics/myCobot/releases/download/0/myCobot.V1.3.zip
    unzip myCobot.V1.3.zip
    cp myCobot固件烧录器V1.3/ino/boot_app0.bin $SRC_DIR/myCobot-Firmware/ino
    cp myCobot固件烧录器V1.3/ino/bootloader_qio_80m.bin $SRC_DIR/myCobot-Firmware/ino
    cp myCobot固件烧录器V1.3/ino/AtomMain2.3.ino.bin $SRC_DIR/myCobot-Firmware/ino
    cp myCobot固件烧录器V1.3/ino/AtomMain2.3.ino.partitions.bin $SRC_DIR/myCobot-Firmware/ino
    cp myCobot固件烧录器V1.3/ino/Transponder.ino.bin $SRC_DIR/myCobot-Firmware/ino
    cp myCobot固件烧录器V1.3/ino/Transponder.ino.partitions.bin $SRC_DIR/myCobot-Firmware/ino
}

download_atom_main2p4 () {
    cd $SRC_DIR/downloads
    if [ ! -e mystudio-windows-v004.zip ]; then
        wget https://github.com/elephantrobotics/myStudio/releases/download/v0.0.4/mystudio-windows.zip -O mystudio-windows-v004.zip
    fi
    if [ ! -d mystudio-v004 ]; then
        unzip mystudio-windows-v004.zip -d mystudio-v004
    fi
    if [ ! -d mystudio-v004/app ]; then
        pushd mystudio-v004
        $SRC_DIR/downloads/innoextract-1.9-linux/innoextract mystudio.exe
        popd
    fi
    cp $SRC_DIR/downloads/mystudio-v004/app/ino/boot_app0.bin $SRC_DIR/myCobot-Firmware/ino
    cp $SRC_DIR/downloads/mystudio-v004/app/ino/bootloader_qio_80m.bin $SRC_DIR/myCobot-Firmware/ino
    cp $SRC_DIR/downloads/mystudio-v004/app/ino/atom/AtomMain2.4.ino.bin $SRC_DIR/myCobot-Firmware/ino
    cp $SRC_DIR/downloads/mystudio-v004/app/ino/atom/AtomMain2.4.ino.partitions.bin $SRC_DIR/myCobot-Firmware/ino
    cp $SRC_DIR/downloads/mystudio-v004/app/ino/tools/Transponder.ino.bin $SRC_DIR/myCobot-Firmware/ino
    cp $SRC_DIR/downloads/mystudio-v004/app/ino/tools/Transponder.ino.partitions.bin $SRC_DIR/myCobot-Firmware/ino
}

download_atom_main2p5 () {
    cd $SRC_DIR/downloads
    if [ ! -e mystudio-windows-v005.zip ]; then
        wget https://github.com/elephantrobotics/myStudio/releases/download/v0.0.5/mystudio-windows.zip -O mystudio-windows-v005.zip
    fi
    if [ ! -d mystudio-v005 ]; then
        unzip mystudio-windows-v005.zip -d mystudio-v005
    fi
    if [ ! -d mystudio-v005/app ]; then
        pushd mystudio-v005
        $SRC_DIR/downloads/innoextract-1.9-linux/innoextract mystudio.exe
        popd
    fi
    cp $SRC_DIR/downloads/mystudio-v005/app/ino/boot_app0.bin $SRC_DIR/myCobot-Firmware/ino
    cp $SRC_DIR/downloads/mystudio-v005/app/ino/bootloader_qio_80m.bin $SRC_DIR/myCobot-Firmware/ino
    cp $SRC_DIR/downloads/mystudio-v005/app/ino/atom/AtomMain2.5.ino.bin $SRC_DIR/myCobot-Firmware/ino
    cp $SRC_DIR/downloads/mystudio-v005/app/ino/atom/AtomMain2.5.ino.partitions.bin $SRC_DIR/myCobot-Firmware/ino
    cp $SRC_DIR/downloads/mystudio-v005/app/ino/tools/Transponder.ino.bin $SRC_DIR/myCobot-Firmware/ino
    cp $SRC_DIR/downloads/mystudio-v005/app/ino/tools/Transponder.ino.partitions.bin $SRC_DIR/myCobot-Firmware/ino
}

download_innoextract () {
    cd $SRC_DIR/downloads
    if [ ! -e innoextract-1.9-linux.tar.xz ]; then
        wget https://constexpr.org/innoextract/files/innoextract-1.9-linux.tar.xz
        tar xvf innoextract-1.9-linux.tar.xz
    fi
}

main () {
    cd $SRC_DIR
    mkdir -p $SRC_DIR/myCobot-Firmware/ino
    mkdir -p $SRC_DIR/downloads
    download_innoextract
    download_atom_main2p5
}

main