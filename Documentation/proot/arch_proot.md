# 📚 Index

## PROOT-DISTRO (🔼 ARCH)
* 🏁 [First steps](#first-steps-arch)
* 💻 [How to install KDE Plasma Desktop](#kde-arch)
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
