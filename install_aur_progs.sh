#!/usr/bin/env bash

aurprogs="progs_aur.txt"

# Install yay first
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd .. && rm -rf yay

while IFS=, read -r prog; do
	yay -S --noconfirm $prog
done < $aurprogs
