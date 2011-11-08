#!/bin/ash

## Umounting /dev/ps3dd2 in case of previous attempts at installs
echo "Attempting to umount /dev/ps3dd2 in case of previous attempts were made at installation..."
umount /dev/ps3dd1
umount /dev/ps3dd2
echo " "


## Creates the directory to chroot to.
echo "Creating chroot directory /mnt/ubuntu"
[ -e /mnt/ubuntu ] || mkdir /mnt/ubuntu
echo " "

## Mounts / to /mnt/ubuntu/
echo " "
echo "Mounting /dev/ps3dd2 to the chroot dir."
mount /dev/ps3dd2 /mnt/ubuntu

cp ./build-kernel.sh /mnt/ubuntu/tmp/build-kernel.sh

## Mounting proc as part of chroot.

echo "chrooting. . ."
sleep 1
mount -t proc none /mnt/ubuntu/proc
mount --rbind /dev /mnt/ubuntu/dev
LANG=C chroot /mnt/ubuntu /bin/bash

