# 📚 Index

> [!NOTE]  
> All the process is described in more detail in this [video](https://youtu.be/9_xUs6CEtVc?si=0HMJ795uduwTvgEc).

## PROOT-DISTRO (⛰️ ALPINE)
* 🏁 [First steps](#first-steps-alpine-proot)
* 💻 [How to install XFCE4 Desktop](#xfce-alpine)
* ⬇️ [Download scripts to run the desktops](#easy-download-alpine-proot)

---

## 🏁 First steps <a name=first-steps-alpine-proot></a>

* First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
pkg install proot-distro
```
* Then install alpine proot: 
```
proot-distro install alpine
```

---  
<br>

## 💻 How to install XFCE4 Desktop <a name=xfce-alpine></a>

* Update and upgrade the default packages: 
```
apk update
apk upgrade
```

* Install needed packages: 
```
apk add sudo nano dbus-x11 xfce4
```

* Create a new user and give it sudo privileges: 
```
adduser droidmaster
nano /etc/sudoers

# Add the following line to the sudoers file
droidmaster All=(ALL:ALL) ALL
```

* If you want to install chromium: 
```
apk add chromium
```


---  
<br>

## ⬇️ Download scripts to run the desktops <a name=easy-download-alpine-proot></a>

* startxfce4_alpine.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_alpine/startxfce4_alpine.sh
chmod +x startxfce4_alpine.sh
./startxfce4_alpine.sh
```
