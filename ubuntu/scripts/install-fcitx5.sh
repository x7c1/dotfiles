#!/bin/sh
#
# Install Fcitx5 with Mozc for Japanese input on Ubuntu. System-level setup
# that home-manager cannot manage on non-NixOS: the system GTK/Qt only load
# IM modules from their own /usr/lib immodules cache, so the frontends have
# to come from apt. home-manager still owns the fonts, the session variables
# and the GNOME settings (home-manager/home/linux-japanese.nix).

set -eux

sudo apt update
sudo apt install -y \
  fcitx5 \
  fcitx5-mozc \
  fcitx5-config-qt \
  fcitx5-frontend-gtk3 \
  fcitx5-frontend-gtk4 \
  fcitx5-frontend-qt5 \
  fcitx5-frontend-qt6 \
  im-config

# Select Fcitx5 as the session input method (writes ~/.xinputrc).
im-config -n fcitx5

# Start Fcitx5 at login. im-config does not on GNOME: its im-launch
# autostart entry runs /usr/bin/true.
mkdir -p "$HOME/.config/autostart"
cp /usr/share/applications/org.fcitx.Fcitx5.desktop "$HOME/.config/autostart/"

cat <<'MSG'

Fcitx5 installed.

Log out and back in, then add Mozc as an input method:

  fcitx5-configtool

Keep "Keyboard - Japanese" first and Mozc second in the default group, so
Ctrl+Space toggles between direct input and Japanese.
MSG
