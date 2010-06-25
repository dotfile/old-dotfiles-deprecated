#!/bin/sh
gnome-settings-daemon &
gnome-power-manager &
gnome-volume-manager &
nm-applet &
exec awesome
