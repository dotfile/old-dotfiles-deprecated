#!/bin/sh

# Gnome, etc. daemons we want. 
gnome-settings-daemon &
gnome-power-manager &
gnome-volume-manager &
nm-applet &

# We can use xscreensaver to lock the system later
xscreensaver -no-splash &

# This must be last
exec awesome
#exec /usr/bin/qtile
