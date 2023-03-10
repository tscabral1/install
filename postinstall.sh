#!/usr/bin/bash


###############################################
#Install Openbox and basic apps on Arch Linux #
#or Arch Linux based distros.                 #
###############################################

#Configure touchpad tap
sudo echo 'Section "InputClass"
Identifier "touchpad"
Driver "libinput"
  MatchIsTouchpad "on"
  Option "Tapping" "on"
  Option "ClickMethod" "buttonareas"
EndSection' > /etc/X11/xorg.conf.d/30-touchpad.conf;

#Autologin
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d;
sudo echo '[Service]
Type=simple
ExecStart=
ExecStart=-/sbin/agetty --autologin thiago --noclear %I 38400 linux' > /etc/systemd/system/getty@tty1.service.d/override.conf
