#!/usr/bin/env bash

aurprogs="progs_aur.txt"

while IFS=, read -r prog; do
	yay -S --noconfirm $prog
done < $aurprogs
