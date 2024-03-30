# Termux Desktops
Collection of scripts to launch Desktops with audio in Termux X11. You have also all the information needed to install your prefered Linux Distro and connect to it in the following steps. 

# 📚 Index

### PROOT-DISTRO (🍥 DEBIAN)
* 🏁 [First steps](#first-steps)
* ⚙️ [Installing Desktops](#installing-desktops)
* 💻 [Running the Desktops to use them with Termux X11](#running-desktops)
* ⬇️ [Download scripts to run the desktops](#easy-download)
* 🎨 [Customizations - Themes](#customizations)
* 🔥 [Hardware acceleration in Termux](https://github.com/LinuxDroidMaster/Termux-Desktops/blob/main/Documentation/HardwareAcceleration.md)

### PROOT-DISTRO (🔼 ARCH)
* 🏁 [First steps](#first-steps-arch)
* ⬇️ [Download scripts to run the desktops](#easy-download-arch)

### TERMUX (NO PROOT)
* 🏁 [First steps](#first-steps-termux)
* 💻 [Running Windows programs on Termux native (XFCE Desktop + Mobox)](#mobox-with-desktop)
* ⬇️ [Download scripts](#easy-download-termux)
* 🎨 [Customizations - Themes](#customizations-termux)

### TERMUX CHROOT - Root needed - ⚠️ Work In Progress ⚠️
* 🏁 [First steps](#first-steps-chroot)
* 💻 [Setting Ubuntu chroot](#ubuntu-chroot)

<br>
<br>  

---  
---  

<br>
<br>

# PROOT-DISTRO (🍥 DEBIAN)

## 🏁 First steps <a name=first-steps></a>
We are going to use Termux and Termux X11 in order to have a full Linux Desktop in our Android devices. 

* [[Video] How to install Termux](https://www.youtube.com/watch?v=OMJAyq5NHp0)

* [[Video] How to install and use Termux X11](https://www.youtube.com/watch?v=mXkXzFqSeYE)

* [[Video] How to install a COMPLETE Linux environtment on ANDROID - Customizing XFCE4 - Neon theme - No Root](https://www.youtube.com/watch?v=rDHyPw_7ETs)

* [[Video] How to install a Linux distro on Android](https://www.youtube.com/watch?v=OMJAyq5NHp0)


<details>
<summary><strong> [Commands] How to install a Linux Distro on Termux with proot-distro (No Root)</strong></summary>

You can check the video described in the First Steps section. The written steps are the following ones: 

1. Open Termux
2. Install proot-distro  
```
pkg update
pkg install proot-distro
```
3. Install Debian (or the distor you prefer)
```
proot-distro install debian
```
4 Log in to the distro 
```
proot-distro login debian
```
</details>

<details>
<summary><strong>[Commands ]Create an user with sudo privileges</summary></strong>

The steps are described in the video linked in the previous point. 

1. Install needed packages
```
apt update -y
apt install sudo nano adduser -y
```
2. Create an user
```
adduser droidmaster
```
3. Give the user sudo privileges
```
nano /etc/sudoers

# Add the following line to the file
droidmaster ALL=(ALL:ALL) ALL
```
4. Check you can execute sudo commands (it should return `root`)
```
sudo whoami 
```  

</details>  

---  
<br>

# ⚙️ Installing Desktops <a name=installing-desktops></a> 

I have installed different desktops, if you want me to test any other just leave a comment in any video and I will check it: 

> [!NOTE]
> In the videos I'm using VNC but with Termux X11 installing the tigervnc server and dbus is no longer required.

* [[Video] How to install XFCE4](https://www.youtube.com/watch?v=LO8LWh5tPg8&list=PL4worxVHtqXo8EPHfLcoy5tPwjVSaqdB5&index=6)

```
# Commands: 
proot-distro login debian --user droidmaster
```
```
sudo apt install xfce4
```

* [[Video] How to install LXDE](https://www.youtube.com/watch?v=9b9_9YNsCXc)
```
# Commands: 
proot-distro login debian --user droidmaster
```
```
sudo apt install lxde
```

* [[Video] How to install Cinnamon](https://youtu.be/_wZO5RZu2R8?feature=shared)
```
# Commands: 
proot-distro login debian --user droidmaster
```
```
sudo apt install cinnamon -y
```

* [[Video] How to install GNOME](https://www.youtube.com/watch?v=XedxyTTHYnI)
```
# Commands: 
proot-distro login debian --user droidmaster
```
```
sudo apt install dbus-x11 nano gnome gnome-shell gnome-terminal gnome-tweaks gnome-software nautilus gnome-shell-extension-manager gedit tigervnc-tools gnupg2 -y
```
```
for file in $(find /usr -type f -iname "*login1*"); do rm -rf $file
done
```

* [[Video] How to install KDE Plasma](https://www.youtube.com/watch?v=fru4SWvUowI&list=PL4worxVHtqXo8EPHfLcoy5tPwjVSaqdB5&index=2)  - Not recommended due to performance issues (KDE Plasma requires more resources)
```
# Commands: 
proot-distro login debian --user droidmaster
```
```
sudo apt install kde-plasma-desktop
```

---  
<br>

## 💻 Running the Desktops for use with Termux X11 <a name=running-desktops></a>
All the scripts in this repository are prepared to run the different Desktops with audio in an easy way. 

First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
```

Then, you just need to download the script corresponding to the Desktop you have installaded, give it permissions to execute it and run it (in Termux, not in proot-distro): 
```
# Download the script to Termux
chmod +x startxfce4_debian.sh
./startxfce4_debian.sh
```

---  
<br>

## ⬇️ Download scripts easily: <a name=easy-download></a> 

> [!NOTE]  
> By default this script works with the user "droidmaster". If you create a user with a different name in proot-distro, please change where it says "droidmaster" inside the scripts.

* startgnome_debian.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_debian/startgnome_debian.sh
```

* startxfce4_debian.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_debian/startxfce4_debian.sh
```

* startlxde_debian.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_debian/startlxde_debian.sh
```

* startcinnamon_debian.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_debian/startcinnamon_debian.sh
```

* startkde_debian.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_debian/startkde_debian.sh
```
---  
<br>

## 🎨 Customizations <a name=customizations></a>
* How to install nerd fonts (this allows you to have icons in the terminal):
```
bash -c  "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"
```
* [How to customize XFCE4 - Neon Theme](https://www.youtube.com/watch?v=rDHyPw_7ETs)


---  
<br>

# PROOT-DISTRO (🔼 ARCH)

## 🏁 First steps <a name=first-steps-arch></a>
All the process is described in more detail in this [video]().

First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
pkg install proot-distro
```

Then install Arch and login once it finishes: 
```
proot-distro install archlinux
proot-distro login archlinux
```

Update repositories and install any package you want: 
```
pacman -Sy
pacman -Syu

pacman -S sudo
pacman -S xfce4
```

---  
<br>

## ⬇️ Download scripts easily: <a name=easy-download-arch></a> 

> [!NOTE]  
> By default this script works with the user "droidmaster". If you create a user with a different name in proot-distro, please change where it says "droidmaster" inside the scripts. And remember to give execution permissions to the script with `chmod +x scriptName.sh`

* startxfce4_arch.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_arch/startxfce4_arch.sh
```


---  
<br>

# TERMUX (NO PROOT)

## 🏁 First steps <a name=first-steps-termux></a>

> [!NOTE]  
> All the process is described in this [video](https://www.youtube.com/watch?v=rq85dxMb7e4)

First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
```

Then you have to install the desktop you prefer, right now I have only test XFCE4 so here are the steps: 
```
pkg install xfce4
```

If you want to install chromium browser: 
First you need to install the following packages in Termux: 
```
pkg install tur-repo
pkg install chromium
```

If you want to install VS Code: 
```
pkg install tur-repo
pkg install code-oss
```

---  
<br>

## 💻 Running Windows programs on Termux native (XFCE Desktop + Mobox): <a name=mobox-with-desktop></a> 
> [!IMPORTANT]  
> All this process is explaining in the folowing [video - Pending -](). I highly recommend looking at it first 


First of all you need to install Mobox (follow instructions from the official repository): https://github.com/olegos2/mobox

1. Configure your Termux native desktop. I recommend following the process described in this [video](https://www.youtube.com/watch?v=rq85dxMb7e4).

2. Download the following script into the `Download` folder. Thanks to the user `@Feer_C9` on [reddit](https://www.reddit.com/r/termux/comments/1bkzpzz/comment/kwwwxni/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) for this script

* mobox_run.sh: 
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/mobox_run.sh
```

3. Give script execution permissions:
```
chmod +x mobox_run.sh
```

4. Now you can run Wine explorer (from Mobox with all the configurations applied) with the following command: `./run_mobox.sh explorer` but I recommend creating a desktop shortcut. You can download the shortcut direclty into the `Desktop` folder with this command: 

* MoboxExplorer.desktop: 
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/MoboxExplorer.desktop
```
Now you can double click the shortcut in the Termux Desktop (for example XFCE4) and open Mobox explorer to run Windows programs or games. 

---  
<br>

## ⬇️ Download scripts: <a name=easy-download-termux></a> 
* startxfce4_termux.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/startxfce4_termux.sh
```

---  
<br>

## 🎨 Customizations <a name=customizations-termux></a>
* How to install nerd fonts (this allows you to have icons in the terminal):
  1. Go to this page and download any font: [NERD FONTS](https://www.nerdfonts.com/font-downloads)
  2. Paste the .ttf files under the following path:
 ```
# Tip:  /usr is at the same level as /home
/usr/share/fonts
 ```

---  
<br>

# TERMUX CHROOT - Root needed

> [!CAUTION]
> Work In Progress

## 🏁 First steps <a name=first-steps-chroot></a>

> [!NOTE]  
> All the process is described in this [video - Pending]()

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

## 💻 Setting Ubuntu Chroot <a name=ubuntu-chroot></a>

This steps are from Ivon's blog but I modified a little bit some lines. These are the post used: 
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

3. Download [Ubuntu 22.0.4 LTS](https://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/) rootfs: 
```
curl https://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04-base-arm64.tar.gz --output ubuntu.tar.gz

```

4. Unzip the downloaded file and create some folders to mount the sdcard
```
tar xpvf ubuntu.tar.gz

mkdir sdcard
mkdir dev/shm
```

5. Create a start script: 
```
cd ../
nano start.sh
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
busybox mount -t tmpfs -o size=256M tmpfs $UBUNTUPATH/dev/shm

# Mount sdcard
busybox mount --bind /sdcard $UBUNTUPATH/sdcard

# chroot into Ubuntu
busybox chroot $UBUNTUPATH /bin/su - root
```

6. Make the script executable and run it: 
```
chmod +x start.sh
sh start.sh
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

apt install nano net-tools sudo git
```

8. Setup timezone: 
```
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
```

9. Create a new user called `droidmaster` (or the name you prefer)
```
groupadd storage
groupadd wheel
useradd -m -g users -G wheel,audio,video,storage,aid_inet -s /bin/bash droidmaster
passwd droidmaster
```

10. Add the created user to sudoers file to have superuser privileges: 
```
nano /etc/sudoers
```
Add this line: 
```
droidmaster ALL=(ALL:ALL) ALL
```

11. Switch to the created user: 
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
apt-get autopurge snapd

cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
# To prevent repository packages from triggering the installation of Snap,
# this file forbids snapd from being installed by APT.
# For more information: https://linuxmint-user-guide.readthedocs.io/en/latest/snap.html
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
```

14. Exit chroot and modified the `start.sh` script created on step `5`: 
```
nano /data/local/tmp/start.sh
```
Change the last line `busybox chroot $UBUNTUPATH /bin/su - root` to this line: 
```
busybox chroot $UBUNTUPATH /bin/su - user -c "export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4713 && dbus-launch --exit-with-session startxfce4"
```
If you installed other Desktop Environment you need to change the `startxfce4` part. For example for KDE Plasma it should be `startplasma-x11`.

15. Let's run the Desktop Environment. Exit chroot environment and copy the following commands on Termux (you can close everything an reopen Termux to be sure you are outside chroot). 
```
XDG_RUNTIME_DIR=${TMPDIR} termux-x11 :0 -ac &
sudo busybox mount --bind $PREFIX/tmp /data/local/tmp/chrootubuntu/tmp

sh /data/local/tmp/start.sh
```

Now you are inside chroot. Execute this: 
```
sudo chmod -R 777 /tmp
export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4713
dbus-launch --exit-with-session startxfce4 &
```

16. Open Termux X11 and check that you can use the desktop environment. 

