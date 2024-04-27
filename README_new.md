# Android on Linux: Termux X11 Desktops

Collection of scripts to launch Desktops with audio in Termux X11. You have also all the information needed to install your prefered Linux Distro and connect to it in the following steps. 

### You can see it all explained on my Youtube channel: [LinuxDroidMaster](https://www.youtube.com/@LinuxDroidMaster/videos)

# 📚 Index
* 🏁 [First steps](#first-steps)
* 🐧 [Termux native VS Proot-distro VS Chroot](#choose-linux)

<br>
<br>  

---  
---  

<br>
<br>

## Linux Environments Preview
All environments are configured with XFCE4 Desktop but you can change it

| Proot distro (Debian) | Native | Chroot (Debian) |
|---------------------------------------------|---------------------------------------------|---------------------------------------------|
| <img src="/Documentation/images/preview_proot.jpg"/> | <img src="/Documentation/images/preview_native.jpg"/>| <img src="/Documentation/images/preview_chroot.jpg"/>|




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

# 🐧 Termux native VS Proot-distro VS Chroot<a name=choose-linux></a>

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

<br>

# Comparison of Linux Environments on Android

| Feature             | Proot          | Native         | Chroot         |
|---------------------|----------------|----------------|----------------|
| Needs Root?         | ❌ (No)        | ❌ (No)        | ✅ (Yes)       |
| Many Linux Apps?    | ✅ (Yes)   | ❌ (Limited)       | ✅ (Yes)       |
| Performance         | Moderate 💼    | Good 🚀        | Good 🚀   |

- **Needs Root?**: Indicates whether root access is required for setting up the environment.
- **Many Linux Apps?**: Reflects the level of compatibility with various Linux applications.
- **Customization Level**: Describes the extent to which the environment can be customized or configured.
