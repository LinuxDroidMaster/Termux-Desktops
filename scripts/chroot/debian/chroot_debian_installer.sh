#!/bin/bash

# Function to show farewell message
goodbye() {
    echo -e "\e[1;31m[!] Something went wrong. Exiting...\e[0m"
    exit 1
}

# Function to show progress message
progress() {
    echo -e "\e[1;36m[+] $1\e[0m"
}

# Function to show success message
success() {
    echo -e "\e[1;32m[✓] $1\e[0m"
}

# Function to download file
download_file() {
    progress "Downloading file..."
    wget -q -P "$1" "$2"
    if [ $? -eq 0 ]; then
        success "File downloaded successfully in $1"
    else
        echo -e "\e[1;31m[!] Error downloading file. Exiting...\e[0m"
        goodbye
    fi
}

# Function to extract file
extract_file() {
    progress "Extracting file..."
    tar xpvf "$1/debian12-arm64.tar.gz" -C "$1" --numeric-owner >/dev/null 2>&1
    success "File extracted successfully"
}

# Function to download and execute script
download_and_execute_script() {
    progress "Downloading script..."
    wget -q -P "$(dirname "$1")" "https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/chroot/start_debian.sh"
    if [ $? -eq 0 ]; then
        success "Script downloaded successfully"
        progress "Setting script permissions..."
        chmod +x "$1/start_debian.sh"
        success "Script permissions set"
    else
        echo -e "\e[1;31m[!] Error downloading script. Exiting...\e[0m"
        goodbye
    fi
}

# Function to configure Debian chroot environment
configure_debian_chroot() {
    progress "Configuring Debian chroot environment..."
    DEBIANPATH="/data/local/tmp/chrootDebian"

    busybox mount -o remount,dev,suid /data
    busybox mount --bind /dev $DEBIANPATH/dev
    busybox mount --bind /sys $DEBIANPATH/sys
    busybox mount --bind /proc $DEBIANPATH/proc
    busybox mount -t devpts devpts $DEBIANPATH/dev/pts

    mkdir $DEBIANPATH/dev/shm
    busybox mount -t tmpfs -o size=256M tmpfs $DEBIANPATH/dev/shm

    mkdir $DEBIANPATH/sdcard
    busybox mount --bind /sdcard $DEBIANPATH/sdcard
    
    busybox chroot $DEBIANPATH /bin/su - root -c 'apt update -y && apt upgrade -y'
    busybox chroot $DEBIANPATH /bin/su - root -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf; \
    echo "127.0.0.1 localhost" > /etc/hosts; \
    groupadd -g 3003 aid_inet; \
    groupadd -g 3004 aid_net_raw; \
    groupadd -g 1003 aid_graphics; \
    usermod -g 3003 -G 3003,3004 -a _apt; \
    usermod -G 3003 -a root; \
    apt update; \
    apt upgrade; \
    apt install nano vim net-tools sudo git; \
    echo "Debian chroot environment configured"'

    if [ $? -eq 0 ]; then
        success "Debian chroot environment configured"
    else
        echo -e "\e[1;31m[!] Error configuring Debian chroot environment. Exiting...\e[0m"
        goodbye
    fi

    # Prompt for username
    progress "Setting up user account..."
    read -p "Enter username for Debian chroot environment: " USERNAME

    # Add the user
    busybox chroot $DEBIANPATH /bin/su - root -c "adduser $USERNAME"

    # Add user to sudoers
    progress "Configuring sudo permissions..."
    busybox chroot $DEBIANPATH /bin/su - root -c "echo '$USERNAME ALL=(ALL:ALL) ALL' >> /etc/sudoers"

    success "User account set up and sudo permissions configured"
}


# Main function
main() {
    if [ "$(whoami)" != "root" ]; then
        echo -e "\e[1;31m[!] This script must be run as root. Exiting...\e[0m"
        goodbye
    else
        download_dir="/data/local/tmp/chrootDebian"
        if [ ! -d "$download_dir" ]; then
            mkdir -p "$download_dir"
            success "Created directory $download_dir"
        fi
        download_file "$download_dir" "https://github.com/LinuxDroidMaster/Termux-Desktops/releases/download/Debian/debian12-arm64.tar.gz"
        extract_file "$download_dir"
        download_and_execute_script "$download_dir"
        configure_debian_chroot
    fi
}

# Call the main function
main
