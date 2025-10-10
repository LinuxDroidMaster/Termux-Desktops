#!/data/data/com.termux/files/usr/bin/bash


# Check if pulseaudio is already running. In case we start multiple x11 instances; gedit for example
# The `pulseaudio --check` command returns 0 if it is running, non-zero otherwise.
pulseaudio --check > /dev/null
if [ $? -ne 0 ]; then
  echo "PulseAudio is not running. Starting PulseAudio daemon."
  # Start the pulseaudio daemon in the background.
  # Ensure $PREFIX/etc/pulse/default.pa  and  $PREFIX/etc/pulse/daemon.conf
  # has been configured to process streaming audio over the network
  pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
  #sleep 2
fi

# Launch Termux X11 main activity
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1

# dynamic script code using eval
exec bash -c "termux-x11 :$$ -xstartup \"$(eval echo $*)\" >/dev/null ; pkill -9 pulseaudio ; exit 0"


