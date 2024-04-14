#!/bin/sh

#Path of DEBIAN rootfs
DEBIANPATH="/data/local/tmp/chrootDebian"

# Fix setuid issue
busybox mount -o remount,dev,suid /data

busybox mount --bind /dev $DEBIANPATH/dev
busybox mount --bind /sys $DEBIANPATH/sys
busybox mount --bind /proc $DEBIANPATH/proc
busybox mount -t devpts devpts $DEBIANPATH/dev/pts

# /dev/shm for Electron apps
busybox mount -t tmpfs -o size=256M tmpfs $DEBIANPATH/dev/shm

# Mount sdcard
busybox mount --bind /sdcard $DEBIANPATH/sdcard

# chroot into DEBIAN
#busybox chroot $DEBIANPATH /bin/su - root
busybox chroot $DEBIANPATH /bin/su - root -c 'export XDG_RUNTIME_DIR=${TMPDIR} && PULSE_SERVER=tcp:127.0.0.1:4713 && sudo service dbus start && su - droidmaster -c "env DISPLAY=:0 startxfce4"'
