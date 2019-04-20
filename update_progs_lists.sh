#!/usr/bin/env bash

# Update official repo packages
pacman -Qent | cut -d ' ' -f 1 > progs_official_repo.txt

# Update AUR packages
pacman -Qm | cut -d ' ' -f 1 > progs_aur.txt
