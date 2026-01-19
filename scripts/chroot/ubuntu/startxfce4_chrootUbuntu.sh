#!/bin/bash

# Kill previous session leftovers
pkill -9 -f com.termux.x11
killall -9 termux-x11 Xwayland pulseaudio virgl_test_server_android termux-wake-lock

# Start Termux-X11
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity

sudo mkdir -p /data/local/tmp/chrootubuntu/tmp
sudo busybox mount --bind $PREFIX/tmp /data/local/tmp/chrootubuntu/tmp

XDG_RUNTIME_DIR=${TMPDIR} termux-x11 :0 -ac &

sleep 3

# Start PulseAudio server
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1

# Start VirGL server uncomment the line below for hardware accel with VirGL
#virgl_test_server_android &

# Execute chroot Ubuntu script
su -c "sh /data/local/tmp/start_ubuntu.sh"
