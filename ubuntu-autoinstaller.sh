#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Ubuntu version:"
    echo "1. Ubuntu 18.04"
    echo "2. Ubuntu 20.04"
    echo "3. Ubuntu 22.04"
    echo "4. Ubuntu 24.04"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Ubuntu 18.04
        img_file="ubuntu1804.img"
        iso_link="https://releases.ubuntu.com/18.04/ubuntu-18.04.6-desktop-amd64.iso"
        iso_file="ubuntu1804.iso"
        ;;
    2)
        # Ubuntu 20.04
        img_file="ubuntu2004.img"
        iso_link="https://releases.ubuntu.com/20.04/ubuntu-20.04.6-desktop-amd64.iso"
        iso_file="ubuntu2004.iso"
        ;;
    3)
        # Ubuntu 22.04
        img_file="ubuntu2204.img"
        iso_link="https://releases.ubuntu.com/22.04/ubuntu-22.04.4-desktop-amd64.iso"
        iso_file="ubuntu2204.iso"
        ;;
    4)
        # Ubuntu 24.04
        img_file="ubuntu2404.img"
        iso_link="https://releases.ubuntu.com/24.04/ubuntu-24.04-desktop-amd64.iso"
        iso_file="ubuntu2404.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected Ubuntu version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 30G

echo "Image file $img_file created successfully."

# Download Ubuntu ISO with the chosen name
wget -O "$iso_file" "$iso_link"

# Verify the ISO download
if [ ! -s "$iso_file" ]; then
    echo "Failed to download $iso_file. Please check the URL or your network connection."
    exit 1
fi

echo "Ubuntu ISO downloaded successfully."
