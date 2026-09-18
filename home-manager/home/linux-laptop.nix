{ lib, ... }:
let
  inherit (lib.hm.gvariant) mkInt32;
in
{
  # Battery-only power policy. The AC side (sleep-inactive-ac-*) is shared
  # with the desktop in linux.nix; a desktop never runs on battery, so this
  # stays out of it.
  dconf.settings."org/gnome/settings-daemon/plugins/power" = {
    sleep-inactive-battery-timeout = mkInt32 (20 * 60);
    sleep-inactive-battery-type = "suspend";
  };
}
