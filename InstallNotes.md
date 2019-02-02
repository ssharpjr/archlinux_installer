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


### Packages to install
#### GUI
- X: xorg-server xorg-apps  xorg-xinit  
- Drivers: xf86-video-intel mesa (lib32-mesa)  
- Desktop: cinnamon  
- Auto-launch Cinnamon: echo cinnamon-session >> ~/.xinitrc


#### Official Repos
- bind-tools blueberry
- dosfstools deja-dup gnome-calculator
- evolution evolution-ews exfat-utils
- filezilla firefox
- git gparted gpodder
- hexchat hunspell-en_us
- libreoffice-fresh nmap neofetch
- python python-pip python-virtualenv tk python-pyqt5 p7zip
- libvncserver  simple-mtpfs openssh
- samba nemo-share gvfs-smb nemo-fileroller (cinnamon nemo)
- seahorse (passwords) traceroute mtr-gtk tree
- ttf-inconsolata ttf-linux-libertine ttf-anonymous-pro ttf-bitstream-vera ttf-dejavu 
- ttf-droid ttf-gentium ttf-liberation ttf-ubuntu-font-family adobe-source-code-pro-fonts
- vlc virtualbox virtualbox-guest-iso virtualbox-host-dkms
- clementine lame opus libvorbis ffmpeg shotwell 
- gstreamer gst-plugins-bad gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-ugly
- system-config-printer cups gnome-screenshot
- wine (enable multilib repo in /etc/pacman.conf)
- xclip rxvt-unicode rxvt-unicode-terminfo urxvt-perls
- youtube-dl youtube-viewer
- zathura zathura-pdf-poppler poppler unzip unrar


#### AUR
- yay (AUR helper)
- dropbox
- google-chrome g810-led-git (Logitech G513 keyboard)
- ipscan gksu
- jre jdk
- manuskript-git
- netextender
- pacmanager-bin
- remmina-git remmina-plugin-rdesktop freerdp-git  (~/.remmina folder)  
- spotify
- ttf-ms-fonts timeshift virtualbox-ext-oracle
- nerd-fonts-complete


#### Manual Install
- etcher (https://www.balena.io/etcher)
- pycharm-community-edition (https://www.jetbrains.com/pycharm)
- virtualenvwrapper (https://virtualenvwrapper.readthedocs.io)
- powerline-shell (https://github.com/b-ryan/powerline-shell)


#### Config Files and Folders
- ~/.config/autostart
- ~/.config/Clementine
- ~/.config/evolution
- ~/.config/hexchat
- ~/.config/menus
- ~/.config/nemo
- ~/.config/newsboat
- ~/.config/ranger
- ~/.config/remmina
- ~/.config/zathura
- ~/.cinnamon
- ~/.remmina
- /etc/hosts
- ~/.ssh
- ~/.bashrc
- ~/.bash_profile
- ~/.conkyrc
- ~/.gvimrc
- ~/.minecraft
- ~/.profile
- ~/.tmux.conf
- ~/.vimrc
- ~/.Xdefaults
- ~/.xinitrc
- ~/.Xresources

#### Workstation Setups
- Install printers


#### Additional Settings
- Evolution Theme
	- Pin Evolution to the panel (Grouped Window List applet)
	- Copy /usr/share/applications/org.gnome.Evolution.desktop to org.gnome.Evolution_Themed.desktop
	- Change the Exec= line to /home/"USERNAME"/bin/evolution_themed.sh
	- Edit ~/.cinnamon/configs/grouped-window-list@cinnamon.org/"number".json
	- Change pinned-apps:value:org.gnome.Evolution.desktop to org.gnome.Evolution_Themed.desktop
	- echo GTK_THEME=Mint-X-Blue evolution > ~/bin/evolution_themed.sh
- LibreOffice Theme


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
