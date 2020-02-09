# Arch Linux Install Notes

Good install reference:  [https://gitlab.com/jsherman82/notes/blob/master/arch.md]

### Install Arch
- wifi-menu
- timedatectl set-ntp true
- fdisk partitions
- mkfs.fat -F32 /dev/sdX (boot/efi partition)
- mkfs.ext4 /dev/sdX (root partition)
- mkswap /dev/sdX (swap partition)
- swapon /dev/sdX (swap partition)
- mount root to /mnt
- mkdir -p /mnt/efi
- mount boot (efi) to /mnt/efi
- pacstrap /mnt base base-devel vim networkmanager intel-ucode grub efibootmgr
- genfstab -U /mnt >> /mnt/etc/fstab
- arch-chroot /mnt
- ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
- hwclock --systohc
- Uncomment "en_US.UTF-8" in /etc/locale.gen
- locale-gen
- echo LANG=en_US.UTF-8 > /etc/locale.conf
- echo "hostname" > /etc/hostname
- Create /etc/hosts
	- 127.0.0.1 localhost
	- ::1 localhost
	- 127.0.1.1 "hostname".localhostdomain "hostname"
- passwd
- grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB --removable
- grub-mkconfig -o /boot/grub/grub.cfg
- exit (chroot)
- umount /mnt/efi; umount /mnt
- reboot

### Post-Install Steps
- Create user:  useradd -m -G wheel "username"; passwd "username"
- systemctl start NetworkManager
- systemctl enable Network Manager.service
- nmtui (setup wifi)

### Install Official Repo Packages
- install_official_progs.sh

### Install AUR Packages
- install_aur_progs.sh

### Install dotfiles
- rm -rf ~/.bash*
- install_dotfiles.sh

### Install ~/bin Files
- git clone https://gitlab.com/ssharpjr/binfiles-backup.git ~/bin

#### Workstation Setups
- Install printers

#### Security
- Disable root from SSH

#### Maintenance Tasks
- Remove orphans: pacman -Rns $(pacman -Qdtq)
- Check for errors: systemctl --failed; journalctl -p 3 -xb

#### Encrypted LVM Install Notes
Possible issue with /run/lvm scanning every /dev when installing Grub.  Follow these steps:  
(on the boot media)  
`mkdir /mnt/hostrun`  
`mount --bind /run /mnt/hostrun`  
`arch-chroot /mnt /bin/bash`  
`mkdir /run/lvm`  
`mount --bind /hostrun/lvm /run/lvm`  
`grub-install` statement  
`grub-mkconfig` statement  
