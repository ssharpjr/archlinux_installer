#!/usr/bin/env bash

# 2_archlinux_installer.sh

# Automate basic Arch Linux install steps.

# Author: Stacey Sharp (https://github.com/ssharpjr)


# You are expected to complete the following step manually PRIOR to running this script.
# - You have run pacstrap (arch_installer_1.sh script for example)
# - You have run genfstab and arch-chroot.

# This script should be in the new /root.

### BEGIN ###
NEW_HOSTNAME="NEWHOSTNAME"
NEW_USER="NEWUSERNAME"

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

# Enable Services
systemctl enable NetworkManager
systemctl enable fstrim.timer

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
rm /root/2_archlinux_installer.sh

echo
echo ==================================================
echo Arch Linux Installer Script Complete
echo
echo Run the following commands to complete the install
echo
echo "exit"  # from the chroot
echo "cd"  # to make sure you are 'home'
echo "umount -a"  # unmount all drives and install media (may see errors)
echo
echo Remove your media drive and reboot your system
echo ==================================================
echo
