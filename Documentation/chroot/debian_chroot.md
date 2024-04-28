> [!CAUTION]
> READ CAREFULLY! When using Chroot environments to exit completely close the Termux application even from the background apps or if necessary force close it. Otherwise, in case you do some command like "rm -rf chrootFolder" the device will go crazy and you will have to force reboot it.

# 📚 Index

## CHROOT (🍥 DEBIAN)
* 🏁 [First steps](#first-steps-chroot)
* 💻🍥 [Setting Debian chroot - automatic installer](#debian-chroot)
* 🤚🍥 [Setting Debian chroot - Manual install](#debian-chroot-manual)
* ⬇️ [Download scripts to run desktops](#easy-download-chroot)
* ⬇️ [Download Debian chroot](#distros-chroot)
* 🎨 [Customizations (Nerdfonts, XFCE4 terminal color palettes, etc)](#customizations-chroot)

<br>

---  
---  

<br>

> [!NOTE]  
> All the process is described in this [video](https://www.youtube.com/watch?v=EDjKBme0DRI)

## 🏁 First steps <a name=first-steps-chroot></a>


1. First you need to have your device <u>rooted</u>.
2. You need to flash [Busybox](https://github.com/Magisk-Modules-Alt-Repo/BuiltIn-BusyBox/releases) with Magisk.
3. Then you need to install the following packages in Termux: 

```
pkg update
pkg install x11-repo
pkg install root-repo
pkg install termux-x11-nightly
pkg update
pkg install tsu
pkg install pulseaudio
```


---  
<br>

## 💻🍥 Setting Debian chroot - automatic installer <a name=debian-chroot></a>

Please read first [#First Steps section](#first-steps-chroot)

* Download the installer with this command: 
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/chroot/debian/chroot_debian_installer.sh
```

* Run it with sudo privileges from Termux: 
```
su
chmod +x chroot_debian_installer.sh
sh chroot_debian_installer.sh
```

---  
<br>

## ⬇️ Download scripts to run desktops <a name=easy-download-chroot></a>

* startxfce4_chrootDebian.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/chroot/debian/startxfce4_chrootDebian.sh
```

---  
<br>

## ⬇️ Download Debian chroot <a name=distros-chroot></a>


* Download Debian 12 rootfs:
```
wget https://github.com/LinuxDroidMaster/Termux-Desktops/releases/download/Debian/debian12-arm64.tar.gz
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

---  
<br>

## 🤚🍥 Setting Debian chroot - Manual install <a name=debian-chroot-manual></a>

1. Enter Android shell with root privileges: 
```
su
```

2. Create a directory at `/data/local/tmp` for chroot environment
```
mkdir /data/local/tmp/chrootDebian
cd /data/local/tmp/chrootDebian
```

3. Download Debian 12 rootfs: 
```
wget https://github.com/LinuxDroidMaster/Termux-Desktops/releases/download/Debian/debian12-arm64.tar.gz
```

4. Unzip the downloaded file and create some folders to mount the sdcard
```
tar xpvf debian12-arm64.tar.gz --numeric-owner

mkdir sdcard
mkdir dev/shm
```

5. Create a start script: 
```
cd ../
vi start_debian.sh
```
Copy and paste the following: 
```
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
mkdir $DEBIANPATH/dev/shm
busybox mount -t tmpfs -o size=256M tmpfs $DEBIANPATH/dev/shm

# Mount sdcard
mkdir $DEBIANPATH/sdcard
busybox mount --bind /sdcard $DEBIANPATH/sdcard

# chroot into DEBIAN
busybox chroot $DEBIANPATH /bin/su - root
```

6. Make the script executable and run it: 
```
chmod +x start_debian.sh
sh start_debian.sh
```

7. The prompt will change to `root@localhost`. If you need to return to Termux just write `exit`. Let's execute some fixes: 
```
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "127.0.0.1 localhost" > /etc/hosts

groupadd -g 3003 aid_inet
groupadd -g 3004 aid_net_raw
groupadd -g 1003 aid_graphics
usermod -g 3003 -G 3003,3004 -a _apt
usermod -G 3003 -a root

apt update
apt upgrade

apt install nano vim net-tools sudo git
```

8. Create a new user called `droidmaster` (or the name you prefer)
```
groupadd storage
groupadd wheel
useradd -m -g users -G wheel,audio,video,storage,aid_inet -s /bin/bash droidmaster
passwd droidmaster
```

9. Add the created user to sudoers file to have superuser privileges: 
```
nano /etc/sudoers
```
Add this line: 
```
droidmaster ALL=(ALL:ALL) ALL
```

10. Install Desktop Environment: 
* XFCE4
```
sudo apt install xfce4
```

11. Exit chroot and modify  the `start_debian.sh` script created on step `5`: 
```
vi /data/local/tmp/start_debian.sh
```
Change the last line `busybox chroot $DEBIANPATH /bin/su - root` to this line: 
```
busybox chroot $DEBIANPATH /bin/su - droidmaster -c 'export DISPLAY=:0 && export PULSE_SERVER=127.0.0.1 && dbus-launch --exit-with-session startxfce4'
```

12. Let's run the Desktop Environment. Exit chroot environment and copy the following commands on Termux (you can close everything an reopen Termux to be sure you are outside chroot). 
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/chroot/debian/startxfce4_chrootDebian.sh

chmod +x startxfce4_chrootDebian.sh
./startxfce4_chrootDebian.sh
```
