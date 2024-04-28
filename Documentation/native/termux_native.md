# 📚 Index

## TERMUX NATIVE (NO PROOT)
* 🏁 [First steps](#first-steps-termux)
* 💻 [How to install apps inside Termux native desktop](#apps-termux-native)
* 💻 [Running Windows programs on Termux native (XFCE Desktop + Mobox)](#mobox-with-desktop)
* ⬇️ [Download scripts](#easy-download-termux)
* 🎨 [Customizations - Themes](#customizations-termux)

<br>

---  
---  
<br>

> [!NOTE]  
> All the process to setup a Desktop Environment in Termux Native is described in this [video](https://www.youtube.com/watch?v=rq85dxMb7e4)

<br>

## 🏁 First steps <a name=first-steps-termux></a>



First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
```

Then you have to install the desktop you prefer, right now I have only test XFCE4 so here are the steps: 
```
pkg install xfce4
```

If you want to install chromium browser: 
First you need to install the following packages in Termux: 
```
pkg install tur-repo
pkg install chromium
```

If you want to install VS Code: 
```
pkg install tur-repo
pkg install code-oss
```

---  
<br>

## 💻 How to install apps inside Termux native desktop <a name=apps-termux-native></a> 
### You have all the information to install apps inside your native Termux Desktop in this [video](https://www.youtube.com/watch?v=JCDAGNiuy3o)

---  
<br>

## 💻 Running Windows programs on Termux native (XFCE Desktop + Mobox): <a name=mobox-with-desktop></a> 
> [!IMPORTANT]  
> All this process is explaining in the folowing [video](https://www.youtube.com/watch?v=SfCKHWUwAr0). I highly recommend looking at it first 


First of all you need to install Mobox (follow instructions from the official repository): https://github.com/olegos2/mobox

1. Configure your Termux native desktop. I recommend following the process described in this [video](https://www.youtube.com/watch?v=rq85dxMb7e4).

2. Download the following script into the `Download` folder. Thanks to the user `@Feer_C9` on [reddit](https://www.reddit.com/r/termux/comments/1bkzpzz/comment/kwwwxni/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) for this script

* mobox_run.sh: 
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/mobox_run.sh
```

3. Give script execution permissions:
```
chmod +x mobox_run.sh
```

4. Now you can run Wine explorer (from Mobox with all the configurations applied) with the following command: `./mobox_run.sh explorer` but I recommend creating a desktop shortcut. You can download the shortcut direclty into the `Desktop` folder with this command: 

* MoboxExplorer.desktop: 
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/MoboxExplorer.desktop
```
Now you can double click the shortcut in the Termux Desktop (for example XFCE4) and open Mobox explorer to run Windows programs or games. 

---  
<br>

## ⬇️ Download scripts: <a name=easy-download-termux></a> 
* startxfce4_termux.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/startxfce4_termux.sh
```

---  
<br>

## 🎨 Customizations <a name=customizations-termux></a>
* How to install nerd fonts (this allows you to have icons in the terminal):
  1. Go to this page and download any font: [NERD FONTS](https://www.nerdfonts.com/font-downloads)
  2. Paste the .ttf files under the following path:
 ```
# Tip:  /usr is at the same level as /home
/usr/share/fonts
 ```