# 📚 Index

## PROOT-DISTRO (🟠 UBUNTU)
* 🏁 [First steps](#first-steps-ubuntu-proot)
* ⬇️ [Download scripts to run the desktops](#easy-download-ubuntu-proot)
* ⚙️ [Installing Desktops](#installing-desktops-ubuntu-proot)

<br>

---  
---  

<br>

## 🏁 First steps <a name=first-steps-ubuntu-proot></a>

> [!NOTE]  
> All the process is described in more detail in this [video](https://www.youtube.com/watch?v=_vxhzSG2zVQ).

First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
pkg install proot-distro
```

Then install Ubuntu and login once it finishes: 
```
proot-distro install ubuntu
proot-distro login ubuntu
```

Update repositories and install any package you want: 
```
apt update 
apt upgrade

apt install sudo nano adduser -y
```

---  
<br>

## ⬇️ Download scripts easily: <a name=easy-download-ubuntu-proot></a> 
* startgnome_ubuntu.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_ubuntu/startgnome_ubuntu.sh
```

---  
<br>

# ⚙️ Installing Desktops <a name=installing-desktops-ubuntu-proot></a> 

I have use the following [post](https://ivonblog.com/en-us/posts/termux-proot-distro-ubuntu/) from Ivon's blog as a reference for some steps. 

<br>

<details>
<summary><strong> GNOME </strong></summary>

<br>

> [!NOTE]  
> All the process is described in more detail in this [video](https://www.youtube.com/watch?v=_vxhzSG2zVQ).

<br>


```
# Commands: 
proot-distro login ubuntu --user droidmaster
```
```
sudo apt install dbus-x11 ubuntu-desktop -y
```
Run this command after it finishes: 
```
for file in $(find /usr -type f -iname "*login1*"); do rm -rf $file
done
```
Disable snapd as it doesn't work on Termux
```
cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
# To prevent repository packages from triggering the installation of Snap,
# this file forbids snapd from being installed by APT.
# For more information: https://linuxmint-user-guide.readthedocs.io/en/latest/snap.html
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
```

Install firefox: 
```
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt-get update
sudo apt-get install firefox-esr
```

Now you can run Ubuntu with GNOME UI from the script I left in the `Download scripts easily` section: 
```
chmod +x startgnome_ubuntu.sh
./startgnome_ubuntu.sh
```
</details>  

<br>

<details>
<summary><strong> Other desktosp (XFCE4, Mate, LXDE, etc) </strong></summary>
<br>

Follow the same [installation steps](https://github.com/LinuxDroidMaster/Termux-Desktops/blob/main/Documentation/proot/debian_proot.md#installing-desktops) as for Debian.

</details>  

---  
  

