{ lib, ... }:
let
  inherit (lib.hm.gvariant) mkInt32 mkUint32;
in
{
  # Battery-only power policy. The AC side (sleep-inactive-ac-*) is shared
  # with the desktop in linux.nix; a desktop never runs on battery, so this
  # stays out of it.
  dconf.settings."org/gnome/settings-daemon/plugins/power" = {
    sleep-inactive-battery-timeout = mkInt32 (20 * 60);
    sleep-inactive-battery-type = "suspend";
  };

  # Lock after 10 minutes idle: the screen blanks at idle-delay and locks
  # lock-delay later. idle-delay is pinned to GNOME's 5-minute default so the
  # total stays 10 minutes; lock-delay overrides linux.nix's 4-hour value.
  dconf.settings."org/gnome/desktop/session".idle-delay = mkUint32 (5 * 60);
  dconf.settings."org/gnome/desktop/screensaver".lock-delay =
    lib.mkForce (mkUint32 (5 * 60));
}
