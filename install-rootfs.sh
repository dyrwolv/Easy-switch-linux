#!/bin/bash
mkdir switch-linux
cd ./switch-linux
echo
echo "lets see if we have a root fs in our folder"
echo
echo
echo
linuxfs=true
if [ -f "./linux-fs.zip" ]; then
echo "we found a linux-fs.zip"
linuxfs=false
wehavezip=true
elif [ -f "./linux-fs.tar.bz2" ]; then
echo "we found ./linux-fs.tar.bz2"
wehavezip=false
linuxfs=false
fi
echo
echo
echo
echo $linuxfs

if  $linuxfs ; then

echo "yes yes ye yes"

echo "please download the filesytem of you choice and rename it to linux-fs and run this script again"
	
exit 1
fi



echo
echo
echo
echo
echo
echo "lets open up gparted and create partitions"
echo
echo "please use the readme if you need help with this part"
echo
echo "take note of what /dev/ device is the ext4 partition"
sleep 5
echo
echo
sudo gparted
echo
echo
echo
echo "what was the /dev/ device for the ext4 partition"
read sdcard
echo
echo

echo "are you sure $sdcard is the right device" 
echo "please type it in again if you are sure"
read sdcard
echo
echo
echo $sdcard

mkdir ./sdroot
sudo mount $sdcard ./sdroot
echo "lets extract the root fs onto our sdcard"
echo
echo "checking whether we have a zip or a tar.bz2"
if $wehavezip ; then
sudo unzip -a ./linux-fs.zip -d ./sdroot; sync
fi
if ! $wehavezip ; then
sudo tar xvf ./linux-fs.tar.bz2 -C ./sdroot; sync
fi
#cp ./linux-fs.zip ./sdroot/root; sync

echo
echo
echo
echo "root fs has been extracted, we can un mount it and remove the sd card now"
echo
echo
sudo umount $sdcard

echo
echo
echo
echo "we can now run the exploit and boot linux on our switch"
echo
echo
echo "please run ./boot.sh to launch linux on your switch" 
sleep 2
exit 1
