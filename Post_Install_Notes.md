### Arch Linux Post Install Notes

#### Set Links
* Vi to Vim Link (optional and may need to be removed before installing gvim)
  * ```ln -sf /usr/bin/vim /usr/bin/vi```

#### Add New User to VISUDOERS
* Run ```visudo``` or ```EDITOR=/usr/bin/vim visudo```
* Uncomment the following line:
  * ```# %wheel ALL=(ALL) ALL```
* Or this line to skip using a password (know the risks!)
  * ```# %wheel ALL=(ALL) NOPASSWD: ALL```

#### Set SSD TRIM (Optional)
* [https://wiki.archlinux.org/index.php/Solid_state_drive]

#### Dot Files
[https://www.atlassian.com/git/tutorials/dotfiles]

#### Bin Files
[https://gitlab.com/ssharpjr/binfiles-backup]

#### Python Virtualenv Wrapper
```sudo pip install virtualenvwrapper```

#### Evolution Autologin
Import or delete/recreate a new default keyring (~/.local/share/keyrings) using seahorse

#### Pacman/Makepkg Improvements
* Uncomment/Set ```MAKEFLAGS="-j$(nproc)"``` in ```/etc/makepkg.conf``` [https://wiki.archlinux.org/index.php/Makepkg#Parallel_compilation]
* Update Compression settings in ```/etc/makepkg.conf``` [https://wiki.archlinux.org/index.php/Makepkg#Utilizing_multiple_cores_on_compression]


#### Hardware 
##### Logitech G810 Keyboard
* Update/Replace ```/etc/g810-led/profile```

##### Misc
* Restore Backups
* Restore Private Keys
* Install Printers (derp)
