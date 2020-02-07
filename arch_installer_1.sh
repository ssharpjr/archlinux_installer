#!/usr/bin/env bash

# arch_installer_1.sh

# Automate basic Arch Linux install steps

# You are expected to complete the following step manually PRIOR to running this script.

# ASSUMPTIONS
# - You booted from an Arch Linux USB flash drive.
# - Network up (ex: wifi-menu)
# - UEFI is assumed.  If not, change the partitions and GRUB commands.
# - Intel CPU and are assumed.
# - You have the following formatted partitions:
#   - Partition 1: up to 500MB (550MB MAX), Type: EFI
#   - Partition 2: 4GB (or so), Type: Linux Swap (SKIP if you are using a swapfile)
#   - Partition 3: (Root), Type: Linux EXT4
#   - Partition 4: (Home), Type: Linux EXT4 (SKIP is not used)

# Once your environment is ready, mount the usb drive holding this installer and run it.
# mkdir -p /media; mount /dev/sdb1 /media; cd /media; ./arch_installer_1.sh

# Drive Variables
EFI_PART="/dev/nvme0n1p1"
ROOT_PART="/dev/nvme0n1p2"
# HOME_PART="/dev/sda1"
MEDIA_DIR="/media"
INSTALLER_DIR="${MEDIA_DIR}/archlinux_installer"

### BEGIN ###

# Sync time
timedatectl set-ntp true

# Format Partitions
mkfs.fat -F32 ${EFI_PART}
mkfs.ext4 -F ${ROOT_PART}
# mkswap /dev/sda2
# swapon /dev/sda2

# Mount partitions
mount ${ROOT_PART} /mnt
mkdir -p /mnt/efi
mount ${EFI_PART} /mnt/efi
# mkdir -p /mnt/home
# mount ${HOME_PART} /mnt/home

# Update US Mirrorlist
cp ${INSTALLER_DIR}/etc/pacman.d/mirrorlist /etc/pacman.d

# Pacstrap the system
pacstrap /mnt base linux linux-firmware linux-headers base-devel vim networkmanager intel-ucode grub efibootmgr git openssh os-prober mtools dosfstools

# Generate fstab
genfstab -U /mnt > /mnt/etc/fstab

# Copy files to the new root.
mkdir -p /mnt/etc/pacman.d/hooks
cp ${INSTALLER_DIR}/etc/pacman.conf /mnt/etc/pacman.conf
cp ${INSTALLER_DIR}/etc/pacman.d/hooks/clean_package_cache.hook /mnt/etc/pacman.d/hooks
cp ${INSTALLER_DIR}/etc/pacman.d/mirrorlist /mnt/etc/pacman.d

# Copy the installer files
cp ${INSTALLER_DIR}/arch_installer_2.sh /mnt/root; chmod +x /mnt/root/arch_installer_2.sh

echo
echo ==========================================================
echo Manually run the following commands to continue the install:
echo "arch-chroot /mnt"
echo "bash arch_installer_2.sh"
echo ==========================================================
echo 
