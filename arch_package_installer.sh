#!/usr/bin/env bash

# Installs all of my packages.

tmpdir=$(mktemp -d)
progs_srcfile="progs.csv"
progs_file=$tmpdir/"progs.csv"
pacprogs=$tmpdir/"pacman_progs.txt"
aurprogs=$tmpdir/"aur_progs.txt"
gitprogs=$tmpdir/"git_progs.txt"

rm -rf $progs_file, $pacprogs $aurprogs $gitprogs
touch {$progs_file,$pacprogs,$aurprogs,$gitprogs}

# Remove header line
cat $progs_srcfile | sed '/^#/d' > $progs_file

# Parse the program list into individual files by install type
while IFS=, read -r tag program comment; do
	case "$tag" in
		"") echo -n "$program " | tee -a $pacprogs > /dev/null 2&>1 ;;
		"A") yay -S --noconfirm "$program" 
		"G") echo -n "$program " | tee -a $gitprogs > /dev/null 2&>1 ;;
  esac
done < $progs_file

# Install repo files using pacman
pacman -Syyu --noconfirm --needed < $pacprogs

