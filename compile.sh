#!/bin/bash

#we need to make sure that we have some required tools and if we dont we need to install them
echo "installing required programs"
sudo apt-get install build-essential libssl-dev swig bison flex python3 python-dev python3-pip libusb-1.0-0-dev gparted
sudo pip3 install pyusb==1.0.0

echo
echo
echo

#check and create a new directory for us to work in
if [ ! -d "./switch-linux" ]; then
	mkdir ./switch-linux
	cd ./switch-linux 
else
	cd ./switch-linux
fi

# set up a build enviroment by downloading the cross-compiling tools
echo
echo
echo "setting up build env" #Check if the build-tools exist
echo
echo
if [ ! -d "./build-tool" ]; then
# Control will enter here if ./build-tool doesn't exist.
	echo
	echo
	echo "build-tool doesnt exist, creating directory and downloading"
	echo	
	echo
	mkdir ./build-tool
fi
cd build-tool

linuxgnu="gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz"
linuxgnueabi="gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi.tar.xz"
if [ ! -f $linuxgnu ]; then
	echo
	echo
   echo "File $linuxgnu does not exist."
	echo
	echo
	wget "https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz"
fi
if [ ! -f $linuxgnueabi ]; then
	echo
	echo
   echo "File $linuxgnueabi does not exist."
	echo
	echo
	wget "https://releases.linaro.org/components/toolchain/binaries/latest-7/arm-linux-gnueabi/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi.tar.xz"
fi
	
#now lets extract them into their own folders
	echo
	echo
	echo "we havent extracted the files yet, so lets go do that"
	echo
	echo

	if [ ! -d "./gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu" ]; then
  # Control will enter here if coreboot doesn't exist.
	echo
	echo
	echo "linux-gnu isnt extracted so lets do that" 
	echo
	echo
	tar xvfJ $linuxgnu
fi
if [ ! -d "./gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi" ]; then
	echo
	echo
	echo "$linuxgnueabi hasnt been extracted, lets do that"
	echo
	echo
	tar xvfJ $linuxgnueabi
fi

#now lets set up our path so that we can use the tools

echo
echo
echo 
echo
echo
echo
echo
 
export PATH=$PATH:$PWD/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin:$PWD/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi/bin
echo
echo
echo
echo

cd ../



echo "Let's test to see if the tools work" 

echo
echo
aarch64-linux-gnu-gcc

#Time to Download the repo's for loading switch linux
echo
echo
echo "checking if we already have the repo's"
echo
echo
	if [ ! -d "./shofel2" ]; then
  # Control will enter here if Shofel2 doesn't exist.
echo
echo
echo "we dont have shofel2, so let's download it"
echo
echo
	git clone https://github.com/fail0verflow/shofel2.git
fi

	if [ ! -d "./coreboot" ]; then
  # Control will enter here if coreboot doesn't exist.
	echo
	echo
	echo "we dont have coreboot, so let's download it" 
	echo
	echo
	git clone --recursive --depth=1 https://github.com/fail0verflow/switch-coreboot.git coreboot
fi
	if [ ! -d "./u-boot" ]; then
  # Control will enter here if u-boot doesn't exist.
	echo
	echo
	echo "we dont have u-boot, so let's download it"
	echo
	echo
	git clone https://github.com/fail0verflow/switch-u-boot.git u-boot
fi
	if [ ! -d "./linux" ]; then
  # Control will enter here if linux doesn't exist.
	echo "we dont have linux, so let's download it"
	git clone --depth=1 https://github.com/fail0verflow/switch-linux.git linux
fi
	if [ ! -d "./imx_usb_loader" ]; then
  # Control will enter here if imx usb loader doesn't exist.
	echo "we dont have imx usb loader, so let's download it"
	git clone https://github.com/boundarydevices/imx_usb_loader.git
fi

#Let's Start Compiling
echo
echo "Compiling Shofel2"
echo
cd shofel2/exploit
make -j8
cd ../
cd ../
echo "Shofel2 Compiled"
echo
echo "let's compile U-boot"
cd u-boot
export CROSS_COMPILE=aarch64-linux-gnu-
make nintendo-switch_defconfig 
make -j8
cd ../

echo "U-boot Compiled"

echo "time to compile coreboot"

cd coreboot
echo "lets Check if we have tegra_mtc.bin"
Tegra_mtc="./tegra_mtc.bin"
if [ ! -f $Tegra_mtc ]; then
	echo "File $Tegra_mtc does not exist."
	echo "downloading pixel c Stock image"
	wget "https://dl.google.com/dl/android/aosp/ryu-opm1.171019.026-factory-8f7df218.zip"
	unzip ./ryu-opm1.171019.026-factory-8f7df218.zip 
	make iasl -j8 
	make nintendo_switch_defconfig
	cd ./util/cbfstool
	make -j8
	cd ../
	cd ../
	./util/cbfstool/cbfstool ./ryu-opm1.171019.026/bootloader-dragon-google_smaug.7900.97.0.img extract -n fallback/tegra_mtc -f tegra_mtc.bin 
else
echo "we found $Tegra_mtc"
fi
echo
echo
echo
export CROSS_COMPILE=aarch64-linux-gnu-
echo "Lets compile it"
echo
echo
echo "1"
make nintendo_switch_defconfig
make iasl
echo
echo 
make -j8
echo
cd ../
echo
echo
aarch64-linux-gnu-gcc
echo
echo
echo
echo

#lets compile imx usb loader

echo
echo "compiling Imx usb loader"
echo

cd imx_usb_loader

echo
echo "doing the git reset"
echo

git reset --hard 0a322b01cacf03e3be727e3e4c3d46d69f2e343e

echo
echo "compiling it"
echo

make -j8
cd ../

echo
echo
echo


#lets cd into the linux dir
cd linux
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
echo
echo
mkdir extra_firmware
if [ ! -f "/lib/firmware/nvidia/tegra210/vic04_ucode.bin" ]; then
	echo "downloading extra firmware"
	wget "http://ftp.us.debian.org/debian/pool/non-free/f/firmware-nonfree/firmware-misc-nonfree_20170823-1_all.deb"
	sudo dpkg -x ./firmware-misc-nonfree_20170823-1_all.deb ./extra_firmware
	sudo dpkg -x ./firmware-misc-nonfree_20170823-1_all.deb ./extra_firmware
	sudo cp ./extra_firmware/vic04_ucode.bin /lib/firmware/nvidia/tegra210/vic04_ucode.bin
	sudo cp ./extra_firmware/xusb.bin /lib/firmware/nvidia/tegra210/xusb.bin
fi

if [ ! -f "/lib/firmware/brcm/brcmfmac4356-pcie.txt" ]; then
	wget "https://chromium.googlesource.com/chromiumos/third_party/linux-firmware/+/f151f016b4fe656399f199e28cabf8d658bcb52b/brcm/brcmfmac4356-pcie.txt"

	sudo cp ./brcmfmac4356-pcie.txt /lib/firmware/brcm/brcmfmac4356-pcie.txt
fi

echo "compiling linux kernel"
make nintendo-switch_defconfig
make -j8

echo
echo
#echo "downloading arch linux rootfs with hardware acceleration and kde"
echo
echo
cd ../
#wget "https://0w0.st/KDE_rootfs3.tar.bz2"
echo "successfully compiled the required files"
echo
echo
echo "go run ./install-rootfs.sh to proceed"
echo
exit 1

