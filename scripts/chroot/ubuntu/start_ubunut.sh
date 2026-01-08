#!/bin/sh

# Ubuntu rootfs path
UBUNTUPATH="/data/local/tmp/chrootubuntu"

# Fix setuid issue
busybox mount -o remount,dev,suid /data

busybox mount --bind /dev $UBUNTUPATH/dev
busybox mount --bind /sys $UBUNTUPATH/sys
busybox mount --bind /proc $UBUNTUPATH/proc
busybox mount -t devpts devpts $UBUNTUPATH/dev/pts

# /dev/shm for Electron apps
mkdir -p $UBUNTUPATH/dev/shm
busybox mount -t tmpfs -o size=256M tmpfs $UBUNTUPATH/dev/shm

# Mount sdcard
busybox mount --bind /sdcard $UBUNTUPATH/sdcard

# Chroot into Ubuntu
#busybox chroot $UBUNTUPATH /bin/su - root
busybox chroot $UBUNTUPATH /bin/su - droidmaster -c \
"export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4713 \
&& dbus-launch --exit-with-session startxfce4"