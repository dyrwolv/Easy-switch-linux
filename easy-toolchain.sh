
#mkdir ./build-tool
#cd build-tool

#linuxgnu="gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz"
#linuxgnueabi="gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi.tar.xz"

#wget "https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz"

#wget "https://releases.linaro.org/components/toolchain/binaries/latest-7/arm-linux-gnueabi/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi.tar.xz"

#	tar xvfJ $linuxgnu

#	tar xvfJ $linuxgnueabi

#	echo
#	echo "cd into build-tool"
	
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
	echo "cd into build-tool"
echo
	echo "run source /etc/environment  and then run"
	echo "PATH=$PATH:$PWD/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin:$PWD/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi/bin"4