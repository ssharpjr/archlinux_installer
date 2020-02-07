#!/usr/bin/env bash

# arch_installer_2.sh

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

# - You have run pacstrap (arch_installer_1.sh script for example)
# - You have run genfstab and arch-chroot.

# This script should be in the new /root.

### BEGIN ###
NEW_HOSTNAME="sshzbookg5"
NEW_USER="ssharp"

# Set Locale and Language
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
sed -i "s/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g" /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
cat <<EOF > /etc/hosts
127.0.0.1    localhost
::1          localhost
127.0.1.1    $NEW_HOSTNAME.localdomain $NEW_HOSTNAME
EOF

echo $NEW_HOSTNAME > /etc/hostname

# Start Networking
systemctl enable NetworkManager

# Set Root password
echo
echo Set Root Password
passwd

# Create new user
useradd -m -G wheel $NEW_USER
echo
echo Set password for ${NEW_USER}
passwd $NEW_USER

# Install GRUB
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

# Cleaning up
echo
echo Cleaning up
rm /root/arch_installer_2.sh
exit
umount /mnt/efi && umount /mnt
umount /media
echo
echo ==================================================
echo Arch Linux Installer Script Complete
echo
echo Run the following commands to complete the install
echo
echo "exit"
echo "cd"
echo "umount -a"
echo
echo Remove your media drive and reboot your system
echo ==================================================
echo
