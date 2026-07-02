#!/bin/bash

gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# This should work for all QT/KDE apps
# if you have the Breeze Dark theme installed.
lookandfeeltool -platform offscreen \
      --apply "org.kde.breezedark.desktop"

# You can set the theme for GTK apps here as well
# if you run into problems.
dbus-send --session --dest=org.kde.GtkConfig \
      --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme \
      "string:Breeze-dark-gtk"
