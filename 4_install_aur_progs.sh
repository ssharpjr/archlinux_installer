#!/usr/bin/env bash

# Install a list of AUR packages
# It is recommended to add the following to /etc/makepkg.conf 
#  ```MAKEFLAGS="-j$(nproc)"

aurprogs="progs_aur.txt"

# Install yay first
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd .. && rm -rf yay

while IFS=, read -r prog; do
	yay -S --noconfirm $prog
done < $aurprogs
