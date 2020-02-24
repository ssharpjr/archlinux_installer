# Arch Linux Installer Stuff

Stuff I use to install Arch Linux

### Install Process
* Edit Installer scripts and package files
  * ```1_archlinux_installer.sh```
  * ```2_archlinux_installer.sh```
  * ```3_install_official_progs.sh```
  * ```4_install_aur_progs.sh```
  * ```5_install_dotfiles.sh``` _Please install your own dotfiles :)_
  * ```progs_official_repo.txt```
  * ```progs_aur.txt```
* Run ```1_archlinux_installer.sh``` and follow the steps.

### Post Install Notes
See [Post_Install_Notes.md]



### Other Notes
__Get Explicitly-Installed (Official Repo) Packages__  
```pacman -Qent | cut -d ' ' -f 1 > progs_official_repo.txt```

__Get Manually-Installed (AUR) Packages__    
```pacman -Qm | cut -d ' ' -f 1 > progs_aur.txt```
