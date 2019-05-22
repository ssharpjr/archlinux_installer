#!/usr/bin/env bash

# Update official repo packages
echo Updating Official Arch Repos
pacman -Qent | cut -d ' ' -f 1 > progs_official_repo.txt
echo Total Official Packages:  $(cat progs_official_repo.txt | wc -l)

# Update AUR packages
echo Updating AUR Repos
pacman -Qm | cut -d ' ' -f 1 > progs_aur.txt
echo Total AUR Packages: $(cat progs_aur.txt | wc -l)
