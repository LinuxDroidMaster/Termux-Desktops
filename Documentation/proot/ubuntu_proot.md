# 📚 Index

## PROOT-DISTRO (🟠 UBUNTU)
* 🏁 [First steps](#first-steps-ubuntu-proot)
* ⬇️ [Download scripts to run the desktops](#script-download-ubuntu-proot)
* ⚙️ [Installing Desktops](#installing-desktops-ubuntu-proot)

<br>

---  
---  

<br>

## 🏁 First steps <a name=first-steps-ubuntu-proot></a>

> [!NOTE]  
> All the process is described in more detail in this [video](https://www.youtube.com/watch?v=_vxhzSG2zVQ) (outdated).

First you need to install the following packages in Termux: 
```
pkg update \
&& pkg install x11-repo \
&& pkg install termux-x11-nightly pulseaudio proot-distro wget
```

Then install Ubuntu and login once it finishes: 
```
proot-distro install ubuntu
proot-distro login ubuntu
```

Update repositories and install any package you want: 
```
apt update && apt upgrade
apt install sudo vim -y
```

---
<br> 

## ⬇️ Download launch scripts: <a name=script-download-ubuntu-proot></a>

* startxfce4_ubuntu.sh

```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_ubuntu/startxfce4_ubuntu.sh
```

* startplasma_ubuntu.sh

```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_ubuntu/startplasma_ubuntu.sh
```

---  
<br>

# ⚙️ Installing Desktops <a name=installing-desktops-ubuntu-proot></a> 

I have use the following [post](https://ivonblog.com/en-us/posts/termux-proot-distro-ubuntu/) from Ivon's blog as a reference for some steps.

## ️️🖥️ Desktop environments

1. Remove PPA:

```
# install ppa-purge
apt install ppa-purge

# remove mozilla team ppa
ppa-purge ppa:mozillateam/ppa
```

Remove preference files so it doesn't use the ppa:

```
# use ppa-purge
ppa-purge ppa:mozillateam/ppa

# remove ppa-purge
apt autopurge ppa-purge
```

2. Create a new user and switch to the newly created user:

```
adduser droidmaster
su - droidmaster
```

3. Disable snapd once before installing a desktop environment. It cannot be used inside Termux without a specialized setup.

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

4. Install the desktop environment:

* XFCE4

```
apt install xubuntu-desktop -y
```

* KDE PLASMA

```
apt install kubuntu-desktop -y
```

* CINNAMON

```
apt install ubuntucinnamon-desktop
```

## 🦊 Install Firefox
Note I used the official Mozilla [support page](https://support.mozilla.or/g/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions-recommended) for the content below.

* Import the Mozilla APT repository signing key:

```
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null 
```

* Next, add the Mozilla APT repository to your sources.list:
```
cat <<EOF | sudo tee /etc/apt/sources.list.d/mozilla.sources
Types: deb
URIs: https://packages.mozilla.org/apt
Suites: mozilla
Components: main
Signed-By: /etc/apt/keyrings/packages.mozilla.org.asc
EOF 
```

* Configure APT to prioritize packages from the Mozilla repository:

```
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla 
```

---
