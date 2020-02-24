#!/usr/bin/env bash

# 1_archlinux_installer.sh

# Automate basic Arch Linux install steps.

# Author: Stacey Sharp (https://github.com/ssharpjr)


# You are expected to complete the following step manually PRIOR to running this script.

# ASSUMPTIONS
# - You booted from an Arch Linux USB flash drive.
# - Network up (ex: wifi-menu)
# - UEFI is assumed.  If not, change the partitions and GRUB commands.
# - Intel CPU and graphics are assumed.
# - You have the following formatted partitions:
#   - Partition 1: up to 500MB (550MB MAX), Type: EFI
#   - Partition 2: 4GB (or so), Type: Linux Swap (SKIP if you are using a swapfile)
#   - Partition 3: (Root), Type: Linux EXT4
#   - Partition 4: (Home), Type: Linux EXT4 (SKIP is not used)

# Once your environment is ready, mount the usb drive holding this installer and run it.
# mkdir -p /media; mount /dev/sdb1 /media; cd /media; ./1_archlinux_installer.sh

# Drive Variables
EFI_PART="/dev/nvme0n1p1"
ROOT_PART="/dev/nvme0n1p2"
HOME_PART="/dev/sda1"
# SWAP_PART="/dev/sda2"
MEDIA_DIR="/media"
INSTALLER_DIR="${MEDIA_DIR}/archlinux_installer"

### BEGIN ###

# Sync time
timedatectl set-ntp true

# Format Partitions
mkfs.fat -F32 ${EFI_PART}
mkfs.ext4 -F ${ROOT_PART}
mkfs.ext4 -F ${HOME_PART}
# mkswap ${SWAP_PART}
# swapon ${SWAP_PART}

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
cp ${INSTALLER_DIR}/etc/makepkg.conf /mnt/etc/makepkg.conf

# Copy the installer files
cp ${INSTALLER_DIR}/2_archlinux_installer.sh /mnt/root; chmod +x /mnt/root/2_archlinux_installer.sh

echo
echo ====================================================================
echo Arch Linux Installer Phase 1 Complete.
echo
echo Manually run the following commands as root to continue the install:
echo "cd /root"
echo "arch-chroot /mnt"
echo "bash 2_archlinux_installer.sh"
echo ====================================================================
echo 
