# Easy-switch-linux
Easy Switch linux or ESL


I hold no responsability for anything that happens to your computer or your switch.

this is also still a work in progress but for the most part it should work right now. 
also if you have any issues let me know


Before You run the Script Please download a Filesytem img of your choice and rename it to Linux-fs 


take a microSD card and, using the software of your choice (I used GParted) :
remove every existing partition to only have unallocated space on it (note that you will lose all info on the sd card)

create a small FAT32 partition (it doesnt matter what size but for the the guides purpose use 200Mb) - that'll be mmcbkl0p1, you can label it whatever you want

create an ext4 partition on the remaining part of the card - that'll be mmcblk0p2, you can label it "rootfs"
it's important that the FAT32 partition comes first and the ext4 one comes after - on the Switch, Linux will look for mmcblk0p2, the second partition, if you have scrolling boot logs and then back to RCM it means you did it wrong

