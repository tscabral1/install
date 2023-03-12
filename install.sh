#!/usr/bin/bash


###############################################
#Install Openbox and basic apps on Arch Linux #
#or Arch Linux based distros.                 #
###############################################

#Update system
sudo pacman -Syy;

#Install main Openbox files and additional apps
sudo pacman -S openbox xorg-server xorg-xinit alsa-utils pulseaudio-bluetooth bluez bluez-utils blueman git vim alacritty obconf lxappearance-obconf menumaker tint2;

#Change Grub timeout to 0
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub;
sudo grub-mkconfig -o /boot/grub/grub.cfg;

#Configure bluetooth
sudo sed -i 's/#AutoEnable=true/AutoEnable=true/g' /etc/bluetooth/main.conf;
sudo systemctl enable bluetooth.service;

#Reconfigure Openbox menu
mmaker -vf OpenBox3;

#Create .xinitrc
echo '#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

exec openbox-session' > ~/.xinitrc;


#Startx automatically
echo '#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
. startx
logout
fi' > ~/.bash_profile;

#Run postinstall.sh
wget https://raw.githubusercontent.com/tscabral1/install/main/postinstall.sh;
sudo bash postinstall.sh
