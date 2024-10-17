# 📚 Index

## TERMUX NATIVE (NO PROOT)
* 🏁 [First steps](#first-steps-termux)
* 💻 [How to install apps inside Termux native desktop](#apps-termux-native)
* ⬇️ [Download scripts](#easy-download-termux)
* 💻 [Running Windows programs on Termux native (XFCE Desktop + Mobox)](#mobox-with-desktop)
* 🎨 [Customizations - Themes](#customizations-termux)
* 🪲 [Troubleshooting and fixes](#troubleshoot)

<br>

---  
---  
<br>

> [!NOTE]  
> The process of setting up a Desktop Environment in Termux Native is described in this [video](https://www.youtube.com/watch?v=rq85dxMb7e4)

<br>

## 🏁 First steps <a name=first-steps-termux></a>

Install latest F Droid build of termux

> [!WARNING]
> (NEVER USE THE GOOGLE PLAY STORE VERSION OF TERMUX AS IT IS OUTDATED)

https://f-droid.org/en/packages/com.termux/

First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
```

Install the latest Termux:X11 build artifact(this app is needed for displaying  GUI)

https://github.com/termux/termux-x11/actions/workflows/debug_build.yml

Then you have to install the desktop you prefer, right now I have only tested XFCE4 so here are the steps: 
> [!NOTE]
> xfce4 is really small and efficient which makes it take the least amount of resources compared to other desktop environments.
```
pkg install xfce4
```

If you want to install the firefox browser:
```
pkg install tur-repo
pkg install firefox
```

If you want to install VS Code: 
```
pkg install tur-repo
pkg install code-oss
```

The full list of termux packages could be found here.
> [!TIP]
> The packages are organized in subdirectories. The packages inside the "packages" directory are only terminal based, "x11-packages" have GUIs, root-packages require root and so on

https://github.com/termux/termux-packages

---  
<br>

## 💻 How to install apps inside Termux native desktop <a name=apps-termux-native></a> 
### You have all the information to install apps inside your native Termux Desktop in this [video](https://www.youtube.com/watch?v=JCDAGNiuy3o)

---
<br>

## ⬇️ Download script to start desktop environment: <a name=easy-download-termux></a> 
* startxfce4_termux.sh
```
cd ~

wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/startxfce4_termux.sh
```

To start the desktop environment, run this
```
bash ~/startxfce4_termux.sh
```

---  
<br>

## 💻 (Optional) Running Windows programs on Termux Native (XFCE Desktop + Mobox): <a name=mobox-with-desktop></a> 
> [!IMPORTANT]  
> This whole process is explained in the following [video](https://www.youtube.com/watch?v=SfCKHWUwAr0). I highly recommend looking at it first 


First of all you need to install Mobox (follow instructions from the official repository): https://github.com/olegos2/mobox

1. Configure your Termux native desktop. I recommend following the process described in this [video](https://www.youtube.com/watch?v=rq85dxMb7e4).

2. Download the following script into the `Desktop` folder. Thanks to the user `@Feer_C9` on [reddit](https://www.reddit.com/r/termux/comments/1bkzpzz/comment/kwwwxni/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) for this script

* mobox_run.sh: 
```
wget -P $HOME https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/mobox_run.sh
```

3. Give script execution permissions:
```
chmod +x mobox_run.sh
```

4. Now you can run Wine explorer (from Mobox with all the configurations applied) with the following command: `./mobox_run.sh explorer` but I recommend creating a desktop shortcut. You can download the shortcut direclty into the `Desktop` folder with this command:

* MoboxExplorer.desktop: 
This allows you to double click the shortcut in the Termux Desktop (for example XFCE4) and open Mobox explorer to run Windows programs or games.
Be warned that some applications refuse to run using the explorer(Follow step 5 and "Common problems with mobox" to learn the proper way)
```
wget -P $HOME/Desktop https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/MoboxExplorer.desktop
```
 
5. Assuming you don't have a wine binary already, you can make a mobox_run.sh a symlink called wine.
This would allow you to call "wine" from the terminal on an exe file(Useful specifically as some executables REQUIRES your terminal to be within the executable's directories, otherwise they may not work):
```
ln -s $HOME/mobox_run.sh /data/data/com.termux/files/usr/bin/wine
```
Then to run it, you do the following
wine PATH_TO_EXECUTABLE

### Common problems with Mobox
Some programs and OG Games don't immediately work and require configuration. To fix them, make sure to try each step below followed by attempting to run it.

* Make sure that your current directory is **IN THE SAME** directory as the program you want to execute then use the symlinked wine(step 5) to run it
Example:
```
cd PATH/TO/EXECUTABLE/DIRECTORY
wine PROGRAM.exe
```

* **NOTE:** VERY RECENTLY, a bug was discovered in mobox_run.sh whereby it changed the directory back to home instead of being in the executable's directory which caused some applications to refuse to run. The bug was fixed so make sure to update your mobox_run.sh file using the following
```
wget -P $HOME https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/mobox_run.sh
``` 

* Execute within a wine desktop environment. OG games in particular like to resize the screen's resolution when opening them. mobox doesn't change the resolution of the termux:x11 session so you need to start it within a wine desktop environment like this.(The caveat is that the resolution of the application you run won't be full at least up until a better solution is found)
```
cd PATH/TO/EXECUTABLE/DIRECTORY
wine explorer /desktop=true PROGRAM.exe
```

* Change Dynarec settings
```
mobox
2. Settings
1. Dynarec settings
[Look at the list of presets then select a preset from 1 to 4, the default is 4]
```

* Make sure to use wine staging instead of wine vanilla(OR VICE VERSA). 
(This is relevant as Undertale only worked for me when I was using wine staging, wine vanilla kept on giving me Direct3D errors. Some applications had the opposite effect and some worked with both)

First check if you have the wine you need already installed
```
4. Select current wine container
[Select the wine version you need, if you don't have it, then makes sure to install it using the below then come back here]
```

If you don't have the wine version you need installed, then you can install it.
```
mobox
3. Manage Packages
2. Install wine
[then install the wine version you need]
```

* Perhaps you have tried all of the above but it still didn't work. In that case, just continue messing around with mobox options, ask on [termux's reddit](https://www.reddit.com/r/termux/), [termux's discord](https://discord.gg/termux-641256914684084234), [Mishka's discord(people run a lot of games there)](https://discord.gg/ysZVT7VHKg) as well as [DroidMaster's discord](https://discord.gg/HBFXePeYfc). Let me assure you that it is possible, you just haven't explored deeply enough. Then when you finally get it to work somehow, make sure to tell everyone how you did it as it would help others!

---  
<br>

## 🎨 Customizations <a name=customizations-termux></a>

* How to install nerd fonts (this allows you to have icons in the terminal) - automatic installation: We are going to use [this repository](https://github.com/arnavgr/termux-nf)
```
pkg install curl ncurses-utils zip
curl -fsSL https://raw.githubusercontent.com/arnavgr/termux-nf/main/install.sh | bash
```

* How to install nerd fonts (this allows you to have icons in the terminal) - manual installation:
  1. Go to this page and download any font: [NERD FONTS](https://www.nerdfonts.com/font-downloads)
  2. Paste the .ttf files under the following path:
 ```
# Tip:  /usr is at the same level as /home
/usr/share/fonts
 ```

## Troubleshooting and fixes <a name=troubleshoot></a> 

### Programs/Games are too slow
Check out [hardware acceleration guide](../HardwareAcceleration.md) for better performance

### Termux X11 randomly getting killed/shutdown
You need to disable Phantom Processes using [this guide](https://github.com/EDLLT/TermuxDisablePhantomProcess)

If Termux X11 STILL abruptly gets killed even after disabling Phantom Processes then apply this to both the **Termux app AND Termux X11**
https://dontkillmyapp.com/

WARNING: Doing the above(Disabling Phantom Process killer, following dontkillmyapp) would mean that the Termux X11 session WILL NEVER shutdown unless YOU manually
shut it down. You can do so by running the following command (If you FORGET to shutdown Termux X11 then it might result in battery drain)
```
kill -9 $(pgrep -f "termux.x11") 2>/dev/null
```

You can also download this .desktop file in your desktop

* Shutdown.desktop: 
```
wget -P $HOME/Desktop https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/Shutdown.desktop
```
Double clicking on Shutdown.desktop will close the Termux X11 session immediately.

### Termux:X11's resolution is too big/too small. Cursor issues and cursor's speed is too fast/slow
* To fix the resolution: Pressing the android back key or going home then back to Termux:X11 usually fixes the resolution

* To change the screen scaling: On the other hand, if you find the icons/UI to be too small then you could close the termux:x11 session, go to "Preferences"(ONLY APPEARS IF THE TERMUX X11 SESSION IS NOT RUNNING) and change display resolution mode to scaled then drag the Display Scale % to something that you're satisfied with.

* To change cursor settings: Get into termux:X11's preferences, then enable "Capture external pointer devices when possible" and drag the "Captured pointer speed factor, %" to something you feel comfortable with.
