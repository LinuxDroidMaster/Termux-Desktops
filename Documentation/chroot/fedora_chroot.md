> [!CAUTION]
> READ CAREFULLY! When using Chroot environments to exit completely close the Termux application even from the background apps or if necessary force close it. Otherwise, in case you do some command like "rm -rf chrootFolder" the device will go crazy and you will have to force reboot it.

# 📚 Index
## CHROOT (🔵 FEDORA)
* 🏁 [First steps](#first-steps-chroot)
* 🫚 [Create fedora rootfs tarball](#create-rootfs)
* 💻 [Setting Fedora chroot](#fedora-chroot)

<br>

---  
---  

<br>

> [!NOTE]  
> All the process is described in this [video - pending]()

## 🏁 First steps <a name=first-steps-chroot></a>


1. **You will need a machine running fedora. You can use a live cd or a virtual machine to perform this operation without actually installing fedora.**
2. **You need to have your device <u>rooted</u>.**
3. **You need to flash [Busybox](https://github.com/Magisk-Modules-Alt-Repo/BuiltIn-BusyBox/releases) with Magisk.**
4. **Then you need to install the following packages in Termux:** 
```
pkg update && pkg install x11-repo root-repo && pkg install tsu pulseaudio termux-x11-nightly openssh
```

---  
<br>

## 🫚 Create fedora rootfs tarball <a name=create-rootfs></a>
- **Since Fedora does not provide a minimal rootfs by default, we will create it ourselves.**
- **Enter fedora terminal**
- **Create a folder to create rootfs**
```
sudo mkdir /tmp/rootfs
```
- **Run the following command to generate rootfs**
```
sudo dnf --releasever=41 --installroot=/tmp/rootfs/ --forcearch=aarch64 --use-host-config group install core
```
- **Pack rootfs as tarball**
```
cd /tmp/rootfs
sudo tar -C . -czf fedora-aarch64-rootfs.tar.gz .
```
- **Send rootfs to your device, in this case, scp is used to transfer the file.**
- **You can use any method you know to transfer rootfs**
- **Run the following command in termux**
```
sshd
passwd
```
- **Run the following command in fedora**
> [!NOTE]  
> `your-device-ip`It should be the actual IP address of the device, which you can see in Settings -> About phone -> IP address
```
scp -P 8022 /tmp/rootfs/fedora-aarch64-rootfs.tar.gz a@your-device-ip:~/
```
## 💻 Setting Fedora chroot <a name=fedora-chroot></a>
- **Enter Termux super user terminal with the command `su`**
- **Navigate to the folder where you want to install Fedora Chroot and extract the rootfs tar ball.**
```
cd /data/local/tmp
cp $PREFIX/../home/fedora-aarch64-rootfs.tar.gz .
```
- **Create a folder to uncompress the file:**
```
mkdir chrootfedora
cd chrootfedora

tar xvf /data/local/tmp/fedora-aarch64-rootfs.tar.gz --numeric-owner
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
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
```
```
mv -vf hosts etc/hosts
```

- **Create the start script:**
```
cd /data/local/tmp
vi start_fedora.sh
```
```
#!/bin/sh

mnt="/data/local/tmp/chrootfedora"
busybox mount -o remount,dev,suid /data

mount -o bind /dev $mnt/dev/
busybox mount -t proc proc $mnt/proc/
busybox mount -t sysfs sysfs $mnt/sys/
busybox mount -t devpts devpts $mnt/dev/pts/
busybox mount -o bind /sdcard $mnt/media/sdcard
busybox mount -t tmpfs /cache $mnt/var/cache

# /dev/shm for Electron apps
busybox mount -t tmpfs -o size=256M tmpfs $mnt/dev/shm

# chroot into Fedora
busybox chroot $mnt /bin/su - root
```

- **Make the script executable and run it. The prompt will change to `[root@localhost ~]#`**

```
chmod +x start_fedora.sh
sh start_fedora.sh
```
- **Execute some fixes**
```
groupadd -g 3003 aid_inet
groupadd -g 3004 aid_net_raw
groupadd -g 1003 aid_graphics
usermod -G 3003 -a root
```

- **Upgrade the system and install common tools**
```
dnf update
dnf install vim net-tools sudo git
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
visudo
```
```
# Paste this 
droidmaster  ALL=(ALL:ALL) ALL
```

- **Fix locales to avoid weird characters:**
```
dnf install glibc-langpack-en
sudo nano /etc/locale.conf
```
```
# Paste this 
LANG="en_US.UTF-8"
```

- **Install XFCE4 Desktop**
```
sudo dnf group install xfce-desktop desktop-accessibility standard fonts
```

- **Exit the `chroot` environment and modify the `start_fedora.sh` file that we created previously. Comment the last line and add the following one**

```
vi start_fedora.sh

#busybox chroot $mnt /bin/su - root
busybox chroot $mnt /bin/su - droidmaster -c "export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4713 && dbus-launch --exit-with-session startxfce4"
```

- **Let's run the Desktop Environment. Exit chroot environment and copy the following commands on Termux (you can close everything an reopen Termux to be sure you are outside chroot).** 
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/chroot/fedora/startxfce4_chrootFedora.sh 

chmod +x startxfce4_chrootFedora.sh
./startxfce4_chrootfedora.sh
```
