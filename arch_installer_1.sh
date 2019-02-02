#!/usr/bin/env bash

# arch_installer_1.sh

# Automate basic Arch Linux install steps

# You are expected to complete the following step manually PRIOR to running this script.

# ASSUMPTIONS
# - You booted from an Arch Linux USB flash drive.
# - Network up (ex: wifi-menu)
# - UEFI is assumed.  If not, change the partitions and GRUB commands.
# - Intel CPU and graphics are assumed.
# - You have a drive identified as /dev/sda with 3 formatted partitions:
#   - Partition 1: up to 500MB (550MB MAX), Type: EFI
#   - Partition 2: 4GB (or so), Type: Linux Swap
#   - Partition 3: (Root), Type: Linux EXT4


### BEGIN ###

# Sync time
timedatectl set-ntp true

# Format Partitions
mkfs.fat -F32 /dev/sda1
mkfs.ext4 -F /dev/sda3
mkswap /dev/sda2
swapon /dev/sda2

# Mount partitions
mount /dev/sda3 /mnt
mkdir -p /mnt/efi
mount /dev/sda1 /mnt/efi

# Pacstrap the system
pacstrap /mnt base base-devel vim networkmanager intel-ucode grub efibootmgr git

# Generate fstab
genfstab -U /mnt /mnt/etc/fstab

# Copy files to the new root.
cp arch_*.sh /mnt/root; chmod +x /mnt/root arch_*.sh

echo
echo Manually run the following commands:
echo "arch-chroot /mnt"
echo "./arch_installer_2.sh"

