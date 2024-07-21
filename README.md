# Android on Linux: Termux X11 Desktops

Collection of scripts to launch Desktops with audio in Termux X11. You have also all the information needed to install your prefered Linux Distro and connect to it in the following steps. 

### ⚠️ If you want to see the information as it was before the update (as shown in most of the videos) check this out: [README_old.md](README_old.md)

### You can see it all explained on my Youtube channel: [LinuxDroidMaster](https://www.youtube.com/@LinuxDroidMaster/videos)



# 📚 Index
* 🏁 [First steps](#first-steps)
* ⚔️ [Termux native VS Proot-distro VS Chroot](#choose-linux)
* 🐧 [How to install proot distributions: Alpine, Ubuntu, Debian, Arch, Kali Nethunter, Parrot OS, PostMarket OS](#proot-distributions)
* 💀 [How to install Chroot distributions: Ubuntu, Debian, Box64Droid](#chroot-distributions)
* 💻 [How to install Termux Native Desktop](#termux-native)
* 🔥 [Hardware acceleration in Termux](https://github.com/LinuxDroidMaster/Termux-Desktops/blob/main/Documentation/HardwareAcceleration.md)

<br>
<br>  

---  
<br>


## Linux Environments Preview
All environments are configured with XFCE4 Desktop but you can change it

| Proot distro (Debian) | Native | Chroot (Debian) |
|---------------------------------------------|---------------------------------------------|---------------------------------------------|
| <img src="/Documentation/images/preview_proot.jpg"/> | <img src="/Documentation/images/preview_native.jpg"/>| <img src="/Documentation/images/preview_chroot.jpg"/>|


---  
<br>
<br>

# 🏁 First steps <a name=first-steps></a>
We are going to use Termux and Termux X11 in order to have a full Linux Desktop in our Android devices. 

* [[Video] How to install Termux](https://www.youtube.com/watch?v=OMJAyq5NHp0)
* [[Video] How to install and use Termux X11](https://www.youtube.com/watch?v=mXkXzFqSeYE)

Basic packages you need to install on Termux: 

```
pkg update
pkg upgrade
pkg install x11-repo
pkg install termux-x11-nightly
pkg install tur-repo
pkg install pulseaudio
pkg install proot-distro
pkg install wget
pkg install git
```

---  
<br>

# ⚔️ Termux native VS Proot-distro VS Chroot <a name=choose-linux></a>

When setting up Linux on your Android device, you have several options to choose from. Understanding the differences between them can help you decide which environment best suits your needs:

### [1. Termux Native](#termux-native)

- Main video: [Termux native Desktop](https://www.youtube.com/watch?v=rq85dxMb7e4)

Termux native refers to running Linux commands directly within the Termux app without any additional virtualization or containerization. It provides a lightweight and straightforward way to access Linux utilities on your Android device.

### [2. Proot-Distro](#proot-distro)

- Main video: [Debian proot and basic Termux X11 installation](https://www.youtube.com/watch?v=mXkXzFqSeYE)

Proot-Distro is a method that utilizes `proot` (PRoot is a user-space implementation of chroot, mount --bind, and binfmt_misc) to run a full Linux distribution inside a chroot environment. This approach allows you to install and use a wide range of Linux distributions without root access. However, it may have some limitations compared to native installations.

### [3. Chroot](#chroot)

- Main video: [Debian Chroot](https://www.youtube.com/watch?v=EDjKBme0DRI)

Chroot is a Unix command that changes the apparent root directory for the current running process and its children. In the context of running Linux on Android, chroot is often used to create a separate Linux environment alongside the Android system. While it provides a more isolated environment compared to Termux native, it may require more advanced setup and additional tools.

#### Summary

- **Termux Native:** Simple and lightweight, but with limited capabilities compared to full Linux distributions.
- **Proot-Distro:** Allows running full Linux distributions without root access, but may have some limitations.
- **Chroot:** Provides a more isolated environment but requires more complex setup and additional tools.

Consider your requirements and preferences when choosing the Linux environment for your Android device.

---  
<br>

## Comparison of Linux Environments on Android

| Feature             | Proot          | Native         | Chroot         |
|---------------------|----------------|----------------|----------------|
| Needs Root?         | ❌ (No)        | ❌ (No)        | ✅ (Yes)       |
| Many Linux Apps?    | ✅ (Yes)   | ❌ (Limited)       | ✅ (Yes)       |
| Performance         | Moderate 💼    | Good 🚀        | Good 🚀   |

- **Needs Root?**: Indicates whether root access is required for setting up the environment.
- **Many Linux Apps?**: Reflects the level of compatibility with various Linux applications.
- **Customization Level**: Describes the extent to which the environment can be customized or configured.

---  
<br>

## 🐧 How to install proot distributions: Ubuntu, Debian, Arch, Kali Nethunter, Parrot OS, PostMarket OS <a name=proot-distributions></a>

Click on the different icons to see how you can install the distribution of your choice. All of them have a video explaining the process 

| Alpine | Ubuntu | Debian | Arch | Kali NetHunter | Parrot OS | PostMarket | Void |
|--------|--------|------|----------------|----------------|----------------|----------------|----------------|
| <a href="/Documentation/proot/alpine_proot.md"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/New_Logo_Alpine_Linux.svg/1200px-New_Logo_Alpine_Linux.svg.png" alt="Alpine Logo" width="100"></a> | <a href="/Documentation/proot/ubuntu_proot.md"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Logo-ubuntu_cof-orange-hex.svg/1200px-Logo-ubuntu_cof-orange-hex.svg.png" alt="Ubuntu Logo" width="100"></a> | <a href="/Documentation/proot/debian_proot.md"><img src="https://www.shareicon.net/data/2015/09/16/101872_debian_512x512.png" alt="Debian Logo" width="100"></a> | <a href="/Documentation/proot/arch_proot.md"><img src="https://cdn0.iconfinder.com/data/icons/flat-round-system/512/archlinux-512.png" alt="Arch Logo" width="100"></a> | <a href="/Documentation/proot/kalinethunter_proot.md"><img src="https://static-00.iconduck.com/assets.00/distributor-logo-kali-linux-icon-2048x2005-dki611fk.png" alt="Kali Logo" width="100"></a> | <a href="/Documentation/proot/parrotos_proot.md"><img src="https://gdm-catalog-fmapi-prod.imgix.net/ProductLogo/b91dba39-aef6-4808-be11-8eda81f81f56.png" alt="Kali Logo" width="100"></a> | <a href="/Documentation/proot/postmarket.md"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/PostmarketOS_logo.svg/1024px-PostmarketOS_logo.svg.png" alt="PostMarket Logo" width="100"></a> | <a href="/Documentation/proot/voidlinux.md"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Void_Linux_logo.svg/2485px-Void_Linux_logo.svg.png" alt="Void logo" width="100"></a> |

---  
<br>

## 💀 How to install Chroot distributions: Ubuntu, Debian, Box64Droid <a name=chroot-distributions></a>

Click on the different icons to see how you can install the distribution of your choice. All of them have a video explaining the process 

| Ubuntu | Debian | Box64Droid (Ubuntu) | Arch |
|--------|--------|--------|--------|
| <a href="/Documentation/chroot/ubuntu_chroot.md"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Logo-ubuntu_cof-orange-hex.svg/1200px-Logo-ubuntu_cof-orange-hex.svg.png" alt="Ubuntu Logo" width="100"></a> | <a href="/Documentation/chroot/debian_chroot.md"><img src="https://www.shareicon.net/data/2015/09/16/101872_debian_512x512.png" alt="Debian Logo" width="100"></a> | <a href="/Documentation/chroot/box64droid_chroot.md"><img src="https://box64droid.com/wp-content/uploads/2023/10/Box64droid-logo.png" alt="Debian Logo" width="100"></a> | <a href="/Documentation/chroot/arch_chroot.md"><img src="https://cdn0.iconfinder.com/data/icons/flat-round-system/512/archlinux-512.png" alt="Arch Logo" width="100"></a> |

---  
<br>

## 💻 How to install Termux Native Desktop <a name=termux-native></a>
### You have all the information to install a native Termux Desktop and all the available apps [here](/Documentation/native/termux_native.md).
