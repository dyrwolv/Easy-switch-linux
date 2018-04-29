#!/bin/bash

cd ./switch-linux
cd shofel2/exploit
sudo ./shofel2.py cbfs.bin ../../coreboot/build/coreboot.rom
cd ../ 
cd ./usb_loader
echo $PWD
../../u-boot/tools/mkimage -A arm64 -T script -C none -n "boot.scr" -d switch.scr switch.scr.img
sudo ../../imx_usb_loader/imx_usb -c .
