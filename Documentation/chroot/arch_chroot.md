> [!CAUTION]
> READ CAREFULLY! When using Chroot environments to exit completely close the Termux application even from the background apps or if necessary force close it. Otherwise, in case you do some command like "rm -rf chrootFolder" the device will go crazy and you will have to force reboot it.

# 📚 Index

Thanks to `Frodo || 🧠🪱` user from my Discord 😄

## CHROOT (🔼 ARCH)
* 🏁 [First steps](#first-steps-chroot)
* 💻 [Setting Arch chroot](#arch-chroot)

<br>

---  
---  

<br>

> [!NOTE]  
> All the process is described in this [video - pending]()

## 🏁 First steps <a name=first-steps-chroot></a>


1. **First you need to have your device <u>rooted</u>.**
2. **You need to flash [Busybox](https://github.com/Magisk-Modules-Alt-Repo/BuiltIn-BusyBox/releases) with Magisk.**
3. **Then you need to install the following packages in Termux:** 

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

## 💻 Setting Arch chroot <a name=arch-chroot></a>

- **Enter Termux super user terminal with the command `su`**
- **Navigate to the folder where you want to install Arch Chroot and download the rootfs tar ball.**
```
cd /data/local/tmp
wget http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz
```
- **Create a folder to uncompress the file:**
```
mkdir chrootarch
cd chrootarch

tar xvf /data/local/tmp/ArchLinuxARM-aarch64-latest.tar.gz --numeric-owner
```

- **Create needed folders:**
```
mkdir media
mkdir media/sdcard
mkdir dev/shm
```

- **Create `resolv.conf` file, paste the following content and replace the original file**
```
vi resolv.conf
```
```
# Content
nameserver 8.8.8.8
nameserver 8.8.4.4
```
```
mv -vf resolv.conf etc/resolv.conf
```

- **Create `hosts` file, paste the following content and replace the original file**
```
vi hosts
```
```
# Content
127.0.0.1 localhost
```
```
mv -vf hosts etc/hosts
```

- **Create the start script:**
```
cd /data/local/tmp
vi start_arch.sh
```
```
#!/bin/sh

mnt="/data/local/tmp/chrootarch"
busybox mount -o remount,dev,suid /data

mount -o bind /dev $mnt/dev/
busybox mount -t proc proc $mnt/proc/
busybox mount -t sysfs sysfs $mnt/sys/
busybox mount -t devpts devpts $mnt/dev/pts/
busybox mount -o bind /sdcard $mnt/media/sdcard
busybox mount -t tmpfs /cache $mnt/var/cache

# /dev/shm for Electron apps
busybox mount -t tmpfs -o size=256M tmpfs $mnt/dev/shm

# chroot into Arch
busybox chroot $mnt /bin/su - root
```

- **Make the script executable and run it. The prompt will change to `root@localhost`**

```
chmod +x start_arch.sh
sh start_arch.sh
```

- **Comment `CheckSpace` pacman config so we can install and update packages**
```
nano /etc/pacman.conf
```
Now comment the line where it says `CheckSpace` by placing the character `#` at the beginning

- **Initialize pacman keys**
```
rm -r /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinuxarm
pacman-key --refresh-keys
```
Tip: You can edit the mirrorlist and uncomment mirrors close to your location: `nano /etc/pacman.d/mirrorlist`

- **Execute some fixes**
```
groupadd -g 3003 aid_inet
groupadd -g 3004 aid_net_raw
groupadd -g 1003 aid_graphics
usermod -G 3003 -a root
```

- **Upgrade the system and install common tools**
```
pacman -Syu
pacman -S vim net-tools sudo git
```

- **Create a new user, in this case `droidmaster`**
```
groupadd storage
groupadd wheel
useradd -m -g users -G wheel,audio,video,storage,aid_inet -s /bin/bash droidmaster
passwd droidmaster
```

- Add the user to `sudoers` file so you can execute `sudo` commands
```
nano /etc/sudoers
```
```
# Paste this 
droidmaster  ALL=(ALL:ALL) ALL
```

- **Fix locales to avoid weird characters:**
```
sudo nano /etc/locale.gen

# Uncomment en_US UTF-8 UTF-8
```
```
sudo locale-gen
```
```
sudo nano /etc/locale.conf
# Replace LANG=C with LANG=en_US.UTF-8
```

- **Install XFCE4 Desktop**
```
sudo pacman -S xfce4 xfce4-terminal
```

- **Exit the `chroot` environment and modify the `start_arch.sh` file that we created previously. Comment the last line and add the following one**

```
vi start_arch.sh

#busybox chroot $mnt /bin/su - root
busybox chroot $mnt /bin/su - droidmaster -c "export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4713 && dbus-launch --exit-with-session startxfce4"
```

- **Let's run the Desktop Environment. Exit chroot environment and copy the following commands on Termux (you can close everything an reopen Termux to be sure you are outside chroot).** 
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/chroot/arch/startxfce4_chrootArch.sh

chmod +x startxfce4_chrootArch.sh
./startxfce4_chrootArch.sh
```
