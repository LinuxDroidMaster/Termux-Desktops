> [!CAUTION]
> READ CAREFULLY! When using Chroot environments to exit completely close the Termux application even from the background apps or if necessary force close it. Otherwise, in case you do some command like "rm -rf chrootFolder" the device will go crazy and you will have to force reboot it.

# 📚 Index

## CHROOT (🍥 DEBIAN)
* 🏁 [First steps](#first-steps-chroot)
* 💻🍥 [Setting Debian chroot - automatic installer](#debian-chroot)
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