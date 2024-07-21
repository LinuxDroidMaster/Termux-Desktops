# 📚 Index

## PROOT-DISTRO (🔼 ARCH)
* 🏁 [First steps](#first-steps-arch)
* 💻 [How to install KDE Plasma Desktop](#kde-arch)
* 💻 [How to install GNOME Desktop](#gnome-arch)
* ⬇️ [Download scripts to run the desktops](#easy-download-arch)

<br>

---  
---  

<br>

## 🏁 First steps <a name=first-steps-arch></a>
> [!NOTE]  
> All the process is described in more detail in this [video](https://www.youtube.com/watch?v=21yeQ1yMI0o).

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

## 💻 How to install KDE Plasma Desktop <a name=kde-arch></a> 
> [!NOTE]  
> All the process is described in more detail in this [video](https://youtu.be/0PX3I1zLqlY?si=wc43q_5miQWGOns3).


1. Follow first steps
2. Install the following packages in Archlinux proot
* Log into Arch
```
pd login archlinux
```
* Install the packages needed (if you want it lighter you can just install the first packages `pacman -S plasma-desktop sudo dbus`)
```
pacman -S plasma-desktop sudo dbus kde-applications kde-graphics kde-utilities konsole thunar
```
* Add a new user and set a password
```
useradd -m -G wheel droidmaster
passwd droidmaster
```
* Give sudo permissions to the user
```
nano /etc/sudoers
```
```
# Paste the following line
droidmaster ALL=(ALL) ALL
```

---  
<br>

## 💻 How to install GNOME Desktop <a name=gnome-arch></a> 
> [!NOTE]  
> All the process is described in more detail in this [video](https://youtu.be/fiJgjlbRQn4?si=ZnXwQ1805pJl5VrE).

**Thanks to the user [@Windows1105](https://www.reddit.com/user/Windows1105/) for [this post in reddit](https://www.reddit.com/r/termux/comments/1bo10lb/fedora_rawhide_with_gnome_46_updated_installation/)**


1. Follow first steps
2. Install the following packages in Archlinux proot
* Log into Arch
```
pd login archlinux
pacman -Syu

pacman -Sy sudo gnome dbus gnome-terminal gnome-tweaks --needed --noconfirm
```

3. Execute the following command to fix a GNOME error that won't allow us to start the desktop

```
find /usr -type f -iname "*login1*" -exec rm -f {} \; && mkdir /run/dbus
```

4. Add a new user and set a password
```
useradd -m -G wheel droidmaster
passwd droidmaster
```
* Give sudo permissions to the user
```
nano /etc/sudoers
```
```
# Paste the following line
droidmaster ALL=(ALL) ALL
```

5. Customize GNOME: 

* Open Extensions and enable "User Themes"

* Look for a GTK theme on xfce4looks or install a theme from the terminal: 
```
pacman -Ss gtk-theme # To search for the themes available on the repository
pacman -Sy pop-gtk-theme # To install a theme form the previous list
```

* We can do the same with the icon themes: 
```
pacman -Ss icon-theme # To search for the icons available on the repository
pacman -Sy epapirus-icon-theme # To install an icon pack form the previous list
```

* Open Gnome Tweaks and select the theme and the icons installed on the `Appearance` menu





---  
<br>

## ⬇️ Download scripts easily: <a name=easy-download-arch></a> 

> [!NOTE]  
> By default this script works with the user `droidmaster`. If you create a user with a different name in proot-distro, please change where it says `droidmaster` inside the scripts. And remember to give execution permissions to the script with `chmod +x scriptName.sh`

* startxfce4_arch.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_arch/startxfce4_arch.sh
```

* startkde_arch.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_arch/startkde_arch.sh
```

* startgnome_arch.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_arch/startgnome_arch.sh
```
