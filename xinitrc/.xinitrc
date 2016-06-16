#!/bin/bash

export $WALLPAPER=~/img/wallpapers/current

# Run redshift in background - dynamic tuning of color temperature
redshift &

# Keyboard settings ================================================

setxkbmap                     \
	-layout pl            \
	-model  pc105         \
	-option ctrl:nocaps
#	-option compose:rctrl \

# Xcape - when pressed Ctrl is Esc
xcape

# ==================================================================

# merge X preferences
xrdb -merge ~/.Xresources

xset +fp ~/.fonts/

# Set wallpaper
feh --bg-center ~/wallpapers/current

# Run screensaver and locking when suspending
xscreensaver -no-splash &
xss-lock -- xscreensaver-command -lock &

# Automatic removable media mounting
udiskie --quiet --use-udisks2 &

eval `ssh-agent`

# Run WM
exec i3

