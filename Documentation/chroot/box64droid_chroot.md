> [!CAUTION]
> READ CAREFULLY! When using Chroot environments to exit completely close the Termux application even from the background apps or if necessary force close it. Otherwise, in case you do some command like "rm -rf chrootFolder" the device will go crazy and you will have to force reboot it.

# 📚 Index

## CHROOT (🏎️ BOX64DROID)
* 🏁 [First steps](#first-steps-chroot)
* 💻 [Setting the graphical desktop (XFCE4)](#box64droid-chroot)
* [🍷 How to run wine](#box64droid-wine)

<br>

---  
---  

<br>

> [!NOTE]  
> All the process is described in this [video - pending]()

## 🏁 First steps <a name=first-steps-chroot></a>

1. First you need to have your device <u>rooted</u>.
2. Go to the [official Box64Droid repository](https://github.com/Ilya114/Box64Droid?tab=readme-ov-file#installation-instructions) and follow the install instructions

```
curl -o install https://raw.githubusercontent.com/Ilya114/Box64Droid/main/installers/install.sh && chmod +x install && ./install
```

3. Start Box64Droid and wait until all the configuration is applied
```
box64droid --start
```


---  
<br>

## 💻 Setting the graphical desktop (XFCE4) <a name=box64droid-chroot></a>

1. Start box64droid and select `Terminal mode` (option `8`)

```
box64droid --start
# Type 8 and Enter
```

2. Configure Box64Droid to be able to install packages and use `apt` and Internet
```
echo "127.0.0.1 localhost" > /etc/hosts

groupadd -g 3003 aid_inet
groupadd -g 3004 aid_net_raw
groupadd -g 1003 aid_graphics
usermod -g 3003 -G 3003,3004 -a _apt
usermod -G 3003 -a root

apt update
apt upgrade
```

You can install some basic packages to see that everything is fine:
```
apt install nano vim net-tools sudo git -y
```

3. Install XFCE4 Desktop (or the one that you prefer)
```
apt install xfce4 -y
```

4. Disable `Snapd` (it doesn't work on Termux) and install `Firefox`
```
sudo apt install software-properties-common
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt-get update
sudo apt-get install firefox-esr
```

5. Create a script to run the graphical desktop: 

```
nano startGUI.sh
```

Copy and paste the following content: 

```
sudo chmod -R 777 /tmp
export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4713
rm -rf /root/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
dbus-launch --exit-with-session startxfce4 &
```

Execute it
```
chmod +x starGUI.sh
./startGUI.sh
```

---

<br>

## 🍷 How to run wine <a name=box64droid-wine></a>

- **To run Wine you can just execute the following command:** 

```
box64 wine
```

- **I recommend that you change the DPI to make the Wine menus larger. Open `Winecfg`, go to the `Graphics` tab and increase the DPI slide.**
```
box64 wine winecfg
```