#!/usr/bin/env bash

# Installs all of my pacakges.
# This list will be replaced with a csv file eventually.

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed \
	xorg-server xorg-apps xorg-xinit xf86-video-intel mesa \
	cinnamon bind-tools dosfstools deja-dup evolution evolution-ews \
	exfat-utils filezilla firefox git gparted hexchat hunspell-en_US \
	libreoffice-fresh python python-pip python-virtualenv libvncserver \
	samba nemo-share gvfs-smb nemo-fileroller seahorse traceroute mtr \
	ttf-inconsolata ttf-linux-libertine ttf-anonymous-pro ttf-dejavu \
	ttf-bitstream-vera ttf-droid ttf-gentium ttf-liberation \
	ttf-ubuntu-font-family adobe-source-code-pro-fonts vlc virtualbox \
	virtualbox-host-dkms virtualbox-guest-iso clementine lame opus \
	libvorbis ffmpeg shotwell gstreamer gst-plugins-bad tree \
	gst-plugins-base gst-plugins-base-libs gst-plugins-good \
	gst-plugins-ugly xclip rxvt-unicode rxvt-unicode-terminfo urxvt-perls
