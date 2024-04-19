#!/bin/bash

# Function to show farewell message
goodbye() {
    echo -e "\e[1;31m[!] Algo salió mal. Saliendo...\e[0m"
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
    progress "Descargando archivo..."
    if [ -e "$1/$2" ]; then
        echo -e "\e[1;33m[!] El archivo ya existe: $2\e[0m"
        echo -e "\e[1;33m[!] Saltando descarga...\e[0m"
    else
        curl -sS -o "$1/$2" "$3"
        if [ $? -eq 0 ]; then
            success "Archivo descargado exitosamente: $2"
        else
            echo -e "\e[1;31m[!] Error al descargar el archivo: $2. Saliendo...\e[0m"
            goodbye
        fi
    fi
}

# Function to extract file
extract_file() {
    progress "Extrayendo archivo..."
    if [ -d "$1/debian12-arm64" ]; then
        echo -e "\e[1;33m[!] El directorio ya existe: $1/debian12-arm64\e[0m"
        echo -e "\e[1;33m[!] Saltando extracción...\e[0m"
    else
        tar xpvf "$1/debian12-arm64.tar.gz" -C "$1" --numeric-owner >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            success "Archivo extraído exitosamente: $1/debian12-arm64"
        else
            echo -e "\e[1;31m[!] Error al extraer el archivo. Saliendo...\e[0m"
            goodbye
        fi
    fi
}

# Function to download and execute script
download_and_execute_script() {
    progress "Descargando script..."
    if [ -e "$1/start_debian.sh" ]; then
        echo -e "\e[1;33m[!] El script ya existe: $1/start_debian.sh\e[0m"
        echo -e "\e[1;33m[!] Saltando descarga...\e[0m"
    else
        curl -sS -o "$1/start_debian.sh" "https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/chroot/debian/start_debian.sh"
        if [ $? -eq 0 ]; then
            success "Script descargado exitosamente: $1/start_debian.sh"
            progress "Estableciendo permisos para el script..."
            chmod +x "$1/start_debian.sh"
            success "Permisos para el script establecidos"
        else
            echo -e "\e[1;31m[!] Error al descargar el script. Saliendo...\e[0m"
            goodbye
        fi
    fi
}

# Function to configure Debian chroot environment
configure_debian_chroot() {
    progress "Configurando entorno chroot de Debian..."
    DEBIANPATH="/data/local/tmp/chrootDebian"

    # Check if DEBIANPATH directory exists
    if [ ! -d "$DEBIANPATH" ]; then
        mkdir -p "$DEBIANPATH"
        if [ $? -eq 0 ]; then
            success "Directorio creado: $DEBIANPATH"
        else
            echo -e "\e[1;31m[!] Error al crear el directorio: $DEBIANPATH. Saliendo...\e[0m"
            goodbye
        fi
    fi

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
    echo "Entorno chroot de Debian configurado"'

    if [ $? -eq 0 ]; then
        success "Entorno chroot de Debian configurado"
    else
        echo -e "\e[1;31m[!] Error al configurar el entorno chroot de Debian. Saliendo...\e[0m"
        goodbye
    fi

    # Prompt for username
    progress "Configurando cuenta de usuario..."
    echo -n "Ingresa el nombre de usuario para el entorno chroot de Debian: "
    read USERNAME

    # Add the user
    busybox chroot $DEBIANPATH /bin/su - root -c "adduser $USERNAME"

    # Add user to sudoers
    progress "Configurando permisos de sudo..."
    busybox chroot $DEBIANPATH /bin/su - root -c "echo '$USERNAME ALL=(ALL:ALL) ALL' >> /etc/sudoers"
    busybox chroot $DEBIANPATH /bin/su - root -c "usermod -aG aid_inet $USERNAME"

    success "Cuenta de usuario configurada y permisos de sudo configurados"

    # Prompt for desktop environment
    progress "Selecciona un entorno de escritorio para instalar:"
    echo "1. XFCE4"
    echo "2. KDE"
    echo "3. Cinnamon"
    echo "4. Gnome"
    echo -n "Ingresa tu opción (1-4): "
    read DE_OPTION

    # Install selected desktop environment
    case $DE_OPTION in
        1)
            install_xfce4
            ;;
        2)
            install_kde
            ;;
        3)
            install_cinnamon
            ;;
        4)
            install_lxde
            ;;
        *)
            echo -e "\e[1;31m[!] Opción inválida. Saliendo...\e[0m"
            goodbye
            ;;
    esac
}

# Function to install XFCE4 desktop environment
install_xfce4() {
    progress "Instalando XFCE4..."
    busybox chroot $DEBIANPATH /bin/su - root -c 'apt update -y && apt install dbus-x11 xfce4 xfce4-terminal -y'
    echo "Entorno de escritorio: XFCE4" >> "$DEBIANPATH/start_debian.sh"
    download_startxfce4_script
}

# Function to install KDE desktop environment
install_kde() {
    progress "Instalando KDE..."
    busybox chroot $DEBIANPATH /bin/su - root -c 'apt update -y && apt install dbus-x11 kde-plasma-desktop -y'
    echo "Entorno de escritorio: KDE" >> "$DEBIANPATH/start_debian.sh"
}

# Function to install Cinnamon desktop environment
install_cinnamon() {
    progress "Instalando Cinnamon..."
    busybox chroot $DEBIANPATH /bin/su - root -c 'apt update -y && apt install dbus-x11 cinnamon -y'
}

# Function to install LXDE desktop environment
install_lxde() {
    progress "Instalando LXDE..."
    busybox chroot $DEBIANPATH /bin/su - root -c 'apt update -y && apt install dbus-x11 lxde -y'
}

# Function to download startxfce4_chrootDebian.sh script
download_startxfce4_script() {
    progress "Descargando script startxfce4_chrootDebian.sh..."
    if [ "$DE_OPTION" -eq 1 ]; then
        curl -sS -o "$(dirname "$0")/startxfce4_chrootDebian.sh" "https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/chroot/debian/startxfce4_chrootDebian.sh"
        if [ $? -eq 0 ]; then
            success "Script startxfce4_chrootDebian.sh descargado exitosamente"
        else
            echo -e "\e[1;31m[!] Error al descargar el script startxfce4_chrootDebian.sh. Saliendo...\e[0m"
            goodbye
        fi
    fi
}

# Main function
main() {
    if [ "$(whoami)" != "root" ]; then
        echo -e "\e[1;31m[!] Este script debe ejecutarse como root. Saliendo...\e[0m"
        goodbye
    else
        download_dir="/data/local/tmp/chrootDebian"
        if [ ! -d "$download_dir" ]; then
            mkdir -p "$download_dir"
            success "Directorio creado: $download_dir"
        fi
        download_file "$download_dir" "debian12-arm64.tar.gz" "https://github.com/LinuxDroidMaster/Termux-Desktops/releases/download/Debian/debian12-arm64.tar.gz"
        extract_file "$download_dir"
        download_and_execute_script "$download_dir"
        configure_debian_chroot
    fi
}

# Call the main function
echo -e "\e[32m"
cat << "EOF"
___  ____ ____ _ ___  _  _ ____ ____ ___ ____ ____    ____ _  _ ____ ____ ____ ___ 
|  \ |__/ |  | | |  \ |\/| |__| [__   |  |___ |__/    |    |__| |__/ |  | |  |  |  
|__/ |  \ |__| | |__/ |  | |  | ___]  |  |___ |  \    |___ |  | |  \ |__| |__|  |  
                                                                                   
EOF
echo -e "\e[0m"

main
