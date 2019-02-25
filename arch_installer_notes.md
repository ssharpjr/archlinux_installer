## Arch Linux

#### Misc Tweaks

###### Disable turbo boost:
  `# echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo`

###### Disable systemd from handling lid close events:
Edit `/etc/systemd/logind.conf` and set `HandleLidSwitch` to `ignore`.

### Installation procedures
###### Installation procedure (basic install):
  1. Use wifi-menu to connect to network
  2. Start ssh `# systemctl start sshd`
  3. Connect to machine via SSH
  4. Visit https://www.archlinux.org/mirrorlist/ on another computer, generate mirrorlist
  5. Edit /etc/pacman.d/mirrorlist on the Arch computer and paste the faster servers
  6. Update package indexes: `# pacman -Syyy`
  7. Create root partition:

       `# fdisk /dev/sda`

          * o (to create an empty DOS partition table)
          * n
          * 1
          * enter
          * +30G
          * w

  8. Create home partition:

      `# fdisk /dev/sda`

         * n
         * 2
         * enter
         * enter
         * w

  9. `# mkfs.ext4 /dev/sda1`
  10. `# mkfs.ext4 /dev/sda2`
  11. `# mount /dev/sda1 /mnt`
  12. `# mkdir /mnt/home`
  13. `# mount /dev/sda2 /mnt/home`
  14. `# pacstrap -i /mnt base`
  15. `# genfstab -U -p /mnt >> /mnt/etc/fstab`
  16. `# arch-chroot /mnt`
  17. `# pacman -S base-devel openssh grub-bios linux-headers linux-lts linux-lts-headers`
  18. If wireless: `# pacman -S dialog network-manager-applet networkmanager networkmanager-openvpn wireless_tools wpa_supplicant wpa_actiond`  
  19. `# mkinitcpio -p linux`
  20. `# mkinitcpio -p linux-lts`
  21. `# nano /etc/locale.gen` (uncomment en_US.UTF-8)
  22. `# locale-gen`
  23. `# passwd` (for setting root password)
  24. `# grub-install --target=i386-pc --recheck /dev/sda`
  25. `# cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo`
  26. `# grub-mkconfig -o /boot/grub/grub.cfg`
  27. Create swap file:
        * `# fallocate -l 2G /swapfile`
        * `# chmod 600 /swapfile`
        * `# mkswap /swapfile`
        * `# echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab`
  28. `$ exit`
  29. `# umount -a`
  30. `# reboot`

###### General Installation procedure (standard install on EFI):
  1. Use wifi-menu to connect to network
  2. Start ssh `# systemctl start sshd`
  3. Connect to machine via SSH
  4. Visit https://www.archlinux.org/mirrorlist/ on another computer, generate mirrorlist
  5. Edit /etc/pacman.d/mirrorlist on the Arch computer and paste the faster servers
  6. Update package indexes: `# pacman -Syyy`
  7. Create efi partition:

       `# fdisk /dev/sda`

          * g (to create an empty GPT partition table)
          * n
          * 1
          * enter
          * +300M
          * t
          * 1 (For EFI)
          * w

  8. Create root partition:

      `# fdisk /dev/sda`

         * n
         * 2
         * enter
         * +30G
         * w

  9. Create home partition:

       `# fdisk /dev/sda`

          * n
          * 3
          * enter
          * enter
          * w

  10. `# mkfs.fat -F32 /dev/sda1`
  11. `# mkfs.ext4 /dev/sda2`
      `# mkfs.ext4 /dev/sda3`
      `# mount /dev/sda2 /mnt`
  12. `# mkdir /mnt/home`
  13. `# mount /dev/sda3 /mnt/home`
  14. `# pacstrap -i /mnt base`
  15. `# genfstab -U -p /mnt >> /mnt/etc/fstab`
  16. `# arch-chroot /mnt`
  17. `# pacman -S base-devel grub efibootmgr dosfstools openssh os-prober mtools linux-headers linux-lts linux-lts-headers`
  18. `# nano /etc/locale.gen` (uncomment en_US.UTF-8)
  19. `# locale-gen`
  20. Enable `root` logon via `ssh`
  21. `# systemctl enable sshd.service`
  22. `# passwd` (for setting root password)
  23. `# mkdir /boot/EFI`
  24. `# mount /dev/sda1 /boot/EFI`
  25. `# grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck`
  26. `# cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo`
  27. `# grub-mkconfig -o /boot/grub/grub.cfg`
  28. Create swap file:
        * `# fallocate -l 2G /swapfile`
        * `# chmod 600 /swapfile`
        * `# mkswap /swapfile`
        * `# echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab`
  29. `$ exit`
  30. `# umount -a`
  31. `# reboot`

###### Installation procedure (encrypted lvm on EFI):
  1. Use wifi-menu to connect to network
  2. Start ssh `# systemctl start sshd`
  3. Connect to machine via SSH
  4. Visit https://www.archlinux.org/mirrorlist/ on another computer, generate mirrorlist
  5. Edit /etc/pacman.d/mirrorlist on the Arch computer and paste the faster servers
  6. Update package indexes: `# pacman -Syyy`
  7. Create efi partition:

       `# fdisk /dev/sda`

          * g (to create an empty GPT partition table)
          * n
          * 1
          * enter
          * +300M
          * t
          * 1 (For EFI)
          * w

  8. Create boot partition:

      `# fdisk /dev/sda`

         * n
         * 2
         * enter
         * +400M
         * w

  9. Create LVM partition:

       `# fdisk /dev/sda`

          * n
          * 3
          * enter
          * enter
          * t
          * 3
          * 31
          * w

  10. `# mkfs.fat -F32 /dev/sda1`
  11. `# mkfs.ext2 /dev/sda2`
  12. Set up encryption
        * `# cryptsetup luksFormat /dev/sda3`
        * `# cryptsetup open --type luks /dev/sda3 lvm`
  13. Set up lvm:
        * `# pvcreate --dataalignment 1m /dev/mapper/lvm`
        * `# vgcreate volgroup0 /dev/mapper/lvm`
        * `# lvcreate -L 30GB volgroup0 -n lv_root`
        * `# lvcreate -L 250GB volgroup0 -n lv_home`
        * `# modprobe dm_mod`
        * `# vgscan`
        * `# vgchange -ay`
  14. `# mkfs.ext4 /dev/volgroup0/lv_root`
  15. `# mkfs.xfs /dev/volgroup0/lv_home`
  16. `# mount /dev/volgroup0/lv_root /mnt`
  17. `# mkdir /mnt/boot`
  18. `# mkdir /mnt/home`
  19. `# mount /dev/sda2 /mnt/boot`
  20. `# mount /dev/volgroup0/lv_home /mnt/home`
  21. `# pacstrap -i /mnt base`
  22. `# genfstab -U -p /mnt >> /mnt/etc/fstab`
  21. `# arch-chroot /mnt`
  22. `# pacman -S base-devel grub efibootmgr dosfstools openssh os-prober mtools linux-headers linux-lts linux-lts-headers`
  23. Edit `/etc/mkinitcpio.conf` and add `encrypt lvm2` in between `block` and `filesystems`
  24. `# mkinitcpio -p linux`
  25. `# mkinitcpio -p linux-lts`
  26. `# nano /etc/locale.gen` (uncomment en_US.UTF-8)
  27. `# locale-gen`
  28. Enable `root` logon via `ssh`
  29. `# systemctl enable sshd.service`
  30. `# passwd` (for setting root password)
  31. Edit `/etc/default/grub`:
        add `cryptdevice=<PARTUUID>:volgroup0` to the `GRUB_CMDLINE_LINUX_DEFAULT` line
            If using standard device naming, the option will look like this: `cryptdevice=/dev/sda3:volgroup0`
  32. `# mkdir /boot/EFI`
  33. `# mount /dev/sda1 /boot/EFI`
  34. `# grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck`
  35. `# cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo`
  36. `# grub-mkconfig -o /boot/grub/grub.cfg`
  37. Create swap file:
        * `# fallocate -l 2G /swapfile`
        * `# chmod 600 /swapfile`
        * `# mkswap /swapfile`
        * `# echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab`
  38. `$ exit`
  39. `# umount -a`
  40. `# reboot`

###### Installation procedure (lvm with no encryption):
  1. Use wifi-menu to connect to network
  2. Start ssh `# systemctl start sshd`
  3. Connect to machine via SSH
  4. Visit https://www.archlinux.org/mirrorlist/ on another computer, generate mirrorlist
  5. Edit /etc/pacman.d/mirrorlist on the Arch computer and paste the faster servers
  6. Update package indexes: `# pacman -Syyy`
  7. Create efi partition:

       `# fdisk /dev/sda`

          * g (to create an empty GPT partition table)
          * n
          * 1
          * enter
          * +300M
          * t
          * 1 (For EFI)
          * w

  8. Create LVM partition

       `# fdisk /dev/sda`

          * n
          * 2
          * enter
          * enter
          * t
          * 2
          * 31
          * w

  9. `# mkfs.fat -F32 /dev/sda1`
  10. Set up lvm:
        * Non-SSD: `# pvcreate /dev/sda2`
        * SSD: `# pvcreate --dataalignment 1m /dev/sda2`
        * `# vgcreate volgroup0 /dev/sda2`
        * `# lvcreate -L 30GB volgroup0 -n lv_root`
        * `# lvcreate -L 250GB volgroup0 -n lv_home`
        * `# modprobe dm_mod`
        * `# vgscan`
        * `# vgchange -ay`
  11. `# mkfs.ext4 /dev/volgroup0/lv_root`
  12. `# mkfs.xfs /dev/volgroup0/lv_home`
  13. `# mount /dev/volgroup0/lv_root /mnt`
  14. `# mkdir /mnt/home`
  15. `# mount /dev/volgroup0/lv_home /mnt/home`
  16. `# pacstrap -i /mnt base`
  17. `# genfstab -U -p /mnt >> /mnt/etc/fstab`
  18. `# arch-chroot /mnt`
  19. `# pacman -S base-devel grub efibootmgr dosfstools openssh os-prober mtools linux-headers linux-lts linux-lts-headers`
  20. Edit `/etc/mkinitcpio.conf` and add `lvm2` in between `block` and `filesystems`
  21. `# mkinitcpio -p linux`
  22. `# mkinitcpio -p linux-lts`
  23. `# nano /etc/locale.gen` (uncomment en_US.UTF-8)
  24. `# locale-gen`
  25. Enable `root` logon via `ssh`
  26. `# systemctl enable sshd.service`
  27. `# passwd` (for setting root password)
  28. `# mkdir /boot/EFI`
  29. `# mount /dev/sda1 /boot/EFI`
  30. `# grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck`
  31. `# cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo`
  32. `# grub-mkconfig -o /boot/grub/grub.cfg`
  33. Create swap file:
        * `# fallocate -l 2G /swapfile`
        * `# chmod 600 /swapfile`
        * `# mkswap /swapfile`
        * `# echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab`
  34. `$ exit`
  35. `# umount -a
  36. `# reboot`

###### Installation procedure (lvm, mbr):
  1. Use wifi-menu to connect to network
  2. Start ssh `# systemctl start sshd`
  3. Connect to machine via SSH
  4. Visit https://www.archlinux.org/mirrorlist/ on another computer, generate mirrorlist
  5. Edit /etc/pacman.d/mirrorlist on the Arch computer and paste the faster servers
  6. Update package indexes: `# pacman -Syyy`
  7. Partition disk, create lvm partition:
       `# fdisk /dev/sda`
        * o
        * enter
        * w
        * n
        * p
        * 1
        * enter
        * enter
        * t
        * 1
        * 8E
        * w

  8.  Create lvm:
        * Non-SSD: `# pvcreate /dev/sda1`
        * SSD: `# pvcreate --dataalignment 1m /dev/sda1`
        * `# vgcreate volgroup0 /dev/sda1`
        * `# lvcreate -L 30GB volgroup0 -n lv_root`
        * `# lvcreate -L 250GB volgroup0 -n lv_home`
        * `# modprobe dm_mod`
        * `# vgscan`
        * `# vgchange -ay`

  9.  `# mkfs.ext4 /dev/volgroup0/lv_root`
  10. `# mkfs.ext4 /dev/volgroup0/lv_home`
  11. `# mount /dev/volgroup0/lv_root /mnt`
  12. `# mkdir /mnt/home`
  13. `# mount /dev/volgroup0/lv_home /mnt/home`
  14. `# pacstrap -i /mnt base`
  15. `# genfstab -U -p /mnt >> /mnt/etc/fstab`
  16. `# arch-chroot /mnt`
  17. `# pacman -S base-devel openssh grub-bios linux-headers linux-lts linux-lts-headers`
  18. Edit `/etc/mkinitcpio.conf` and add `lvm2` in between `block` and `filesystems`
  19. `# mkinitcpio -p linux`
  20. `# mkinitcpio -p linux-lts`
  21. `# nano /etc/locale.gen (uncomment en_US.UTF-8)`
  22. `# locale-gen`
  23. `# ln -s /usr/share/zoneinfo/America/Detroit /etc/localtime`
  24. `# hwclock --systohc --utc`
  25. Enable `root` logon via `ssh`
  26. `# systemctl enable sshd.service`
  27. `# passwd` (for root)
  28. `# grub-install --target=i386-pc --recheck /dev/sda`
  29. `# cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo`
  30. `# grub-mkconfig -o /boot/grub/grub.cfg`
  31. Create swap file:
        * `# fallocate -l 2G /swapfile`
        * `# chmod 600 /swapfile`
        * `# mkswap /swapfile`
        * `# echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab`

  32. `$ exit`
  33. `# umount /mnt/home`
  34. `# umount /mnt`
  35. `# reboot`

###### Post installation steps:
  1. Fix GNOME app issues: `# localectl set-locale LANG="en_US.UTF-8"`
  2. Add to `fstab`:
	   `tmpfs   /tmp         tmpfs   nodev,nosuid,size=2G          0  0`
  3. If ssd, add `discard` to `fstab`. Example:
	   `UUID=<UUID>	/         	ext4      	defaults,noatime,discard	0 2`
