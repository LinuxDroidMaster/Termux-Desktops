> [!CAUTION]
> READ CAREFULLY! When using Chroot environments to exit completely close the Termux application even from the background apps or if necessary force close it. Otherwise, in case you do some command like "rm -rf chrootFolder" the device will go crazy and you will have to force reboot it.

# 📚 Index

## CHROOT (🟠 UBUNTU)
* 🏁 [First steps](#first-steps-chroot)
* 💻🟠 [Setting Ubuntu chroot](#ubuntu-chroot)
* ⬇️ [Download Ubuntu chroot](#distros-chroot)
* 🎨 [Customizations (Nerdfonts, XFCE4 terminal color palettes, etc)](#customizations-chroot)

<br>

---  
---  

<br>

> [!NOTE]  
> All the process is described in this(outdated) [video](https://www.youtube.com/watch?v=rYJaG0uFtdc)

## 🏁 First steps <a name=first-steps-chroot></a>


1. First you need to have your device <u>rooted</u>.
2. You need to flash [Busybox NDK](https://github.com/Magisk-Modules-Repo/busybox-ndk) with Magisk.
3. Then you need to install the following packages in Termux: 

```
pkg update \
&& pkg install x11-repo root-repo \
&& pkg install termux-x11-nightly sudo pulseaudio
```


---  
<br>

## 💻🟠 Setting Ubuntu chroot <a name=ubuntu-chroot></a>

These steps are from Ivon's blog but I've modified some of the lines. These are the post used: 
* [Install Ubuntu in chroot on Android without Linux Deploy](https://ivonblog.com/en-us/posts/termux-chroot-ubuntu/)
* [How to use Termux X11 - The X server on Android phone](https://ivonblog.com/en-us/posts/termux-x11/)
 

1. Enter Android shell with root privileges: 
```
su
```

2. Create a directory at `/data/local/tmp` for chroot environment
```
mkdir /data/local/tmp/chrootubuntu
cd /data/local/tmp/chrootubuntu
```

3. Download [Ubuntu 24.04 LTS](https://cdimage.ubuntu.com/ubuntu-base/releases/24.04/release/) rootfs: 
```
curl https://cdimage.ubuntu.com/ubuntu-base/releases/24.04/release/ubuntu-base-24.04.3-base-arm64.tar.gz -o ubuntu.tar.gz

```

4. Extract the downloaded file and create sdcard folder
```
tar xpvf ubuntu.tar.gz --numeric-owner
mkdir sdcard
```

5. Create startup script: 
```
cd ..
vi start_ubuntu.sh
```
Copy and paste the following: 
```
#!/bin/sh

# The path of Ubuntu rootfs
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

# chroot into Ubuntu
busybox chroot $UBUNTUPATH /bin/su - root
```

6. Make the script executable and run it: 
```
chmod +x start_ubuntu.sh
sh start_ubuntu.sh
```

7. The prompt will change to `root@localhost`. If you need to return to Termux just write `exit`. Let's perform some fixes: 
```
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "127.0.0.1 localhost" > /etc/hosts

groupadd -g 3003 aid_inet
groupadd -g 3004 aid_net_raw
groupadd -g 1003 aid_graphics
usermod -g 3003 -G 3003,3004 -a _apt
usermod -G 3003 -a root

apt update && apt upgrade

apt install nano vim net-tools sudo git
```

8. Set timezone: 
The interactive shell should prompt you to select your timezone if it doesn't run this: 
```
dpkg-reconfigure tzdata
```

9. Create a new user called `droidmaster` (or the name you prefer): 
```
groupadd storage
groupadd wheel
useradd -m -g users -G wheel,audio,video,storage,aid_inet -s /bin/bash droidmaster
passwd droidmaster
```

10. Add the created user to sudoers file to have superuser privileges: 
```
visudo
```
Add this line (replace `droidmaster` with your prefered name): 
```
droidmaster ALL=(ALL:ALL) ALL
```

11. Switch to the created user: 
```
su - droidmaster
```
And generate locales: 
```
sudo apt install locales
sudo locale-gen en_US.UTF-8
```

12. Install Desktop Environment: 
* XFCE4
```
sudo apt install xubuntu-desktop
```
* KDE Plasma
```
sudo apt install kubuntu-desktop
```

13. Disable Snapd (it can't be used on Termux): 
```
sudo apt-get autopurge snapd

cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
# To prevent repository packages from triggering the installation of Snap,
# this file forbids snapd from being installed by APT.
# For more information: https://linuxmint-user-guide.readthedocs.io/en/latest/snap.html
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
```

14. Exit chroot and modify the `start_ubuntu.sh` script created on step `5`: 
```
vi /data/local/tmp/start_ubuntu.sh
```
 Comment the last line `busybox chroot $UBUNTUPATH /bin/su - root` and write the following line under it: 
```
busybox chroot $UBUNTUPATH /bin/su - droidmaster -c "export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4713 && dbus-launch --exit-with-session startxfce4"
```
If you've installed a different Desktop Environment you need to replace `startxfce4`. For example for KDE Plasma you should replace `startxfce4` with `startplasma-x11`.

15. Let's run the Desktop Environment. Exit chroot environment and download the script with wget on Termux (you can close everything and reopen Termux to be sure you are outside chroot). 
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/chroot/ubuntu/startxfce4_chrootubuntu.sh

chmod +x startxfce4_chrootubuntu.sh
./startxfce4_chrootubuntu.sh
```
</details>

---  
<br>

## ⬇️ Download Ubuntu RootFS <a name=distros-chroot></a>

* Download Ubuntu 24.04 rootfs: 
```
curl https://cdimage.ubuntu.com/ubuntu-base/releases/24.04/release/ubuntu-base-24.04.3-base-arm64.tar.gz -o ubuntu.tar.gz
```

---  
<br>

## 🎨 Customizations (Nerdfonts, XFCE4 terminal color palettes, etc) <a name=customizations-chroot></a>
* XFCE4 color palettes:
  * [Dracula](https://draculatheme.com/xfce4-terminal)
  * [Nordic](https://github.com/nordtheme/xfce-terminal)     

* Installing NerdFonts on chroot env (Debian, Ubuntu) from this [post](https://medium.com/@almatins/install-nerdfont-or-any-fonts-using-the-command-line-in-debian-or-other-linux-f3067918a88c):
```
sudo apt install wget unzip -y
```
```
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv
```