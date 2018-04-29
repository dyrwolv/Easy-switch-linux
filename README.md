# Easy-switch-linux
Easy Switch linux or ESL

I hold no responsability for anything that happens to your computer or your switch.

this is also still a work in progress but for the most part it should work right now. 
also if you have any issues let me know


heres a list of rootfs that people are using.

Stock Arch Linux (useless without UART, you can't even log in) : http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz
Arch Linux with LXDE and touch screen support (credits to @Gigaa) :
Without hardware acceleration : https://0w0.st/rootfs.tar.bz2
With hardware acceleration : https://0w0.st/rootfs2.tar.bz2

With hardware acceleration, Chromium and sudo : https://drive.google.com/open?id=1VIH3GWtBrM4uuVQOQopASYZy4x3Jw1Uv
Arch Linux with Gnome (credits to @00Cancer) : https://0w0.st/gnome__rootfs.tar.bz2
Arch Linux with KDE and GPU power management service (credits to @Gigaa) : https://0w0.st/KDE_rootfs3.tar.bz2



Before You run the Script Please download a Filesytem img of your choice and rename it to Linux-fs 


take a microSD card and, using the software of your choice (I used GParted) :
remove every existing partition to only have unallocated space on it (note that you will lose all info on the sd card)

create a small FAT32 partition (it doesnt matter what size but for the the guides purpose use 200Mb) - that'll be mmcbkl0p1, you can label it whatever you want

create an ext4 partition on the remaining part of the card - that'll be mmcblk0p2, you can label it "rootfs"
it's important that the FAT32 partition comes first and the ext4 one comes after - on the Switch, Linux will look for mmcblk0p2, the second partition, if you have scrolling boot logs and then back to RCM it means you did it wrong

