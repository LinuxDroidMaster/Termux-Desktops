# 📚 Index

> [!NOTE]  
> All the process is described in more detail in this [video - pending]().

## PROOT-DISTRO (🦜 PARROT OS)
* 🏁 [First steps](#first-steps-parrot-proot)
* ⬇️ [Download scripts to run the desktops](#easy-download-parrot-proot)

## 🏁 First steps <a name=first-steps-parrot-proot></a>

* First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
pkg install proot-distro
```

* Then we are going to follow the steps describede here: https://github.com/LinuxDroidMaster/parrotOS-GUI-proot

```
pkg update -y && pkg upgrade -y
pkg install git wget -y
git clone https://github.com/LinuxDroidMaster/parrotOS-GUI-proot
cd parrotOS-GUI-proot
chmod +x setup-parrot-cli
./setup-parrot-cli
```

```
#Inside parrot OS
./install-parrot-desktop
```

* Finally you need to configure everything to have a GUI Desktop (I recommend copy/pasting this commands 1 by 1): 

Note: Change `droidmaster` with your username:
```
apt update

apt install parrot-core -y

apt update
apt upgrade -y

apt install sudo desktop-base xfce4 xfce4-terminal

adduser -m droidamster
echo "droidmaster ALL=(ALL:ALL) ALL" >> /etc/sudoers

apt update
apt install parrot-desktop-mate -y

apt install locales-all -y
sudo dpkg-reconfigure locales
```

You can check and install all parrot tools with the following commands: 
```
sudo apt search parrot-tool # To show all the available packages
```
```
sudo apt install parrot-tools-web #or any other package
```

---  
<br>

## ⬇️ Download scripts easily: <a name=easy-download-parrot-proot></a> 

> [!IMPORTANT]  
> After downloading this script change the username to the one you create. Just replace where it says `droidmaster`.

* startxfce4_parrot.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_parrot/startxfce4_parrot.sh
chmod +x startxfce4_parrot.sh
./startxfce4_parrot.sh
```
