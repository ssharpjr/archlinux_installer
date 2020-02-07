#!/usr/bin/env bash

# arch_post_installer_tasks.sh

# These are recommended tasks to perform after a fresh Arch Linux install


### Set Links ###

# Vi to Vim
# ln -sf /usr/bin/vim /usr/bin/vi

# Add new user to VISUDOERS
# Run 'visudo' and uncomment the following line:
# %wheel ALL=(ALL) ALL
# or this line to skip using a password for sudo
# %wheel ALL=(ALL) NOPASSWD: ALL

# Protect SSDs
# Add 'discard' to your SSD drive options in /etc/fstab
