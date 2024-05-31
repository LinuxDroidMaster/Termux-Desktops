# 📚 Index

> [!NOTE]  
> All the process is described in more detail in this [video](https://youtu.be/G5fJCuKMiVQ?si=pLezKNivGVYsc1Bw).

## PROOT-DISTRO (⏫ POSTMARKET)
* 🏁 [First steps](#first-steps-postmarket-proot)
* 🤚 [Manual install](#postmarket-manual)
* ⬇️ [Download scripts to run the desktops](#easy-download-postmarket-proot)

Thanks to @Windows1105 for his post in Reddit: https://www.reddit.com/r/termux/comments/1c0l7b7/postmarketos_with_plasma_mobile/


## 🏁 First steps <a name=first-steps-postmarket-proot></a>

* First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
pkg install proot-distro
```

---  
<br>

## 🤚 Manual install <a name=postmarket-manual></a>

* Install and login into Alpine on proot-distro
```
pd in alpine
pd login alpine
```

* Inside Alpine we are going to configure everything we need:
```
echo "https://mirror.postmarketos.org/postmarketos/v22.06" >> /etc/apk/repositories
sed -i 's/edge/v3.16/g' /etc/apk/repositories

apk add -u --allow-untrusted postmarketos-keys

apk update && apk upgrade

apk add nano sudo neofetch alpine-conf
addgroup storage
addgroup power
addgroup network
```

* Add and configure a new user. Change `user` with your username and set the password to <b>NUMBERS ONLY</b> (if not you won't be able to login): 

```
adduser -g wheel,audio,video,power,storage,lp,sys,network user
```
```
echo "user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
su user -c "sudo setup-xorg-base postmarketos-ui-plasma-mobile kde-applications-base maliit-keyboard"
```

* Change the os releases: 
```
echo 'PRETTY_NAME="postmarketOS v22.06"
NAME="postmarketOS"
VERSION_ID="v22.06"
VERSION="v22.06"
ID="postmarketos"
ID_LIKE="alpine"
HOME_URL="https://www.postmarketos.org/"
SUPPORT_URL="https://gitlab.com/postmarketOS"
BUG_REPORT_URL="https://gitlab.com/postmarketOS/pmaports/issues"
LOGO="postmarketos-logo"' > /etc/os-release
```

---  
<br>

## ⬇️ Download scripts to run the desktops: <a name=easy-download-postmarket-proot></a> 

* startkde_postmarket.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_postmarket/startkde_postmarket.sh
chmod +x startkde_postmarket.sh
./startkde_postmarket.sh
```
