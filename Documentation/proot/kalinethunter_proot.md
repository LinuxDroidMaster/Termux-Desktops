# 📚 Index

> [!NOTE]  
> All the process is described in more detail in this [video](https://www.youtube.com/watch?v=TbjhxnaCFjs).


## PROOT-DISTRO (🐉 KALI LINUX NETHUNTER)
* 🏁 [First steps](#first-steps-kali-proot)
* ⬇️ [Download scripts to run the desktops](#easy-download-kali-proot)

<br>

---  
---  

<br>

## 🏁 First steps <a name=first-steps-kali-proot></a>

First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
pkg install proot-distro
```

Then install Kali Linux Nethunter with the steps described in the [official web](https://www.kali.org/docs/nethunter/nethunter-rootless/): 
```
termux-setup-storage
pkg install wget
wget -O install-nethunter-termux https://offs.ec/2MceZWr
chmod +x install-nethunter-termux
./install-nethunter-termux
```

Log into Kali, update repositories and install any package you want, for exmample Chromium browser: 
```
sudo apt update -y && sudo apt upgrade -y
sudo apt install chromium -y

# To run Chromium execute the following command once you are inside the Desktop environment: chromium --no-sandbox
```

Also to run the startxfce4_nethunter.sh script you need to add the following line in this file: 
```
nano $PREFIX/bin/nh
```
```
-b /data/data/com.termux/files/usr/tmp:/tmp \
```
In this part: 
```
cmdline="proot \
        --link2symlink \
        -0 \
        -r kali-arm64 \
        -b /dev \
        -b /proc \
        -b /data/data/com.termux/files/usr/tmp:/tmp \ # --> ADD THE LINE HERE
        -b kali-arm64$home:/dev/shm \
        -w $home \
           /usr/bin/env -i \
           HOME=$home \
           PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin \
           TERM=$TERM \
           LANG=C.UTF-8 \
           $start"
```

---  
<br>

## ⬇️ Download scripts easily: <a name=easy-download-kali-proot></a> 

> [!NOTE]  
> The default password for the user `kali` is `kali`. Remember to give execution permissions to the script with `chmod +x startxfce4_nethunter.sh`

* startxfce4_nethunter.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_kali/startxfce4_nethunter.sh
```
