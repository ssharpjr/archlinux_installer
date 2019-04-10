# Arch Linux Installer Stuff

Stuff I use to install Arch Linux

__Get Explicitly-Installed (Official Repo) Packages__  
pacman -Qent | cut -d ' ' -f 1 > progs_official_repo.txt

__Get Manually-Installed (AUR) Packages__    
pacman -Qm | cut -d ' ' -f 1 > progs_aur.txt
