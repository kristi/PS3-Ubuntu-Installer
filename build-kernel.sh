#!/bin/bash

############# Section 2 of Ubuntu Installer ###########
## Had to add this section due to chrooting process. ##
#######################################################


## Adding color to terminal

export TERM=xterm-color

###################### End of Chrooting Process ######################

## Creating Swap Parition and Enabling

echo " "
echo "Setting Swap Parition and Enabling."
echo " "
mkswap /dev/ps3dd1
swapon /dev/ps3dd1


## Git cloning of Kernal)
#echo "Downloading kernel source from git and creating symlink"
#cd /usr/src
#git clone --depth 1 git://git.gitbrew.org/ps3/ps3linux/linux-2.6.git || git clone --depth 1 git://foxbrew.org/ps3linux/linux-2.6.git

#ln -sf /usr/src/linux-2.6 /usr/src/linux
#cp /usr/src/linux/ps3_linux_config /usr/src/linux/.config


## Kernel compilation

echo " "
echo "Starting compilation of kernel. (Takes around 30 mins or less.)"
cd /usr/src/linux
make menuconfig
make
make install
make modules_install
cd /
echo " "
echo "Kernel compiling is done if no errors occured."
echo " "


## Creating kboot.conf entry

echo " "
echo "Creating kboot.conf entries. . ."
echo " "

E=`ls /boot | grep vmlinux`

echo -e "Ubuntu=/boot/$E root=/dev/ps3dd2 noplymouth nosplash\nUbuntu_Hugepages=/boot/$E root=/dev/ps3dd2 hugepages=1 noplymouth nosplash" > /etc/kboot.conf


## Finished

echo " "
echo "Installation is complete. Upon reboot, select your new kboot entry to boot Ubuntu."
echo " "
read -p "Press any key to reboot.  (If system hangs, hold power button for 8 seconds.)"

echo " " 
echo "Enjoy!"

reboot
