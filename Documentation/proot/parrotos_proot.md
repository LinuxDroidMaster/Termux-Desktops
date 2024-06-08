# 📚 Index

> [!NOTE]  
> All the process is described in more detail in this [video](https://www.youtube.com/watch?v=sB0O1UMuuoA).

## PROOT-DISTRO (🦜 PARROT OS)
* 🏁 [First steps](#first-steps-parrot-proot)
* ⬇️ [Download scripts to run the desktops](#easy-download-parrot-proot)
* ⬇️ [Download Parrot OS backups](#download-parrot-backups)

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

* Now you can restore the backup files as I show in the video or continue with the manual installation with the following commands: 
```
#Inside parrot OS
./install-parrot-desktop
```

You can check and install all parrot tools with the following commands: 
```
sudo apt search parrot-tool # To show all the available packages
```
```
sudo apt install parrot-tools-web #or any other package
```

If you want to have all the icons and customization for your Parrot Desktop you can install the following package and you will automatically have the right icons and themes available in XFCE4: 
```
apt install parrot-desktop-mate
```

---  
<br>

## ⬇️ Download scripts easily: <a name=easy-download-parrot-proot></a> 

* startxfce4_parrot.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_parrot/startxfce4_parrot.sh
chmod +x startxfce4_parrot.sh
./startxfce4_parrot.sh
```


---  
<br>

## ⬇️ Download Parrot OS backups <a name=download-parrot-backups></a> 

* [Download backup with everything updated and Hack The Box customization (~5GB) - MEGA](https://mega.nz/file/1al3RQxa#1jbHkQQXx4h00eDAkzyTz3eHZgHYQ_qZzow570JCpk8)
* [Download backup with everything updated and Hack The Box customization (~5GB) - MEDIAFIRE](https://www.mediafire.com/file/biiqgwf43jaj4xr/ParrotBackup_HTBcustom/file)

<img src="/Documentation/images/parrot_htb_backup.jpg"/>

* [Download backup with minimal installation (~2.7GB) - MEGA](https://mega.nz/file/xHVn1ARY#Zhz3lRGa_SSFF_XOLgiGZdyKdesQeGTt_m2sG1A71UI)
* [Download backup with minimal installation (~2.7GB) - MEDIAFIRE](https://www.mediafire.com/file/sogyf9b6uhf4w8e/ParrotBackupXFCE4_nocustomization/file)

<img src="/Documentation/images/parrot_minimal_backup.jpg"/>
