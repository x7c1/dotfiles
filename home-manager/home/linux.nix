{ pkgs, lib, ... }:
let
  inherit (lib.hm.gvariant) mkInt32 mkUint32;
in
{
  home.packages = with pkgs; [
    wl-clipboard
  ];

  dconf.settings = {
    "org/gnome/desktop/peripherals/keyboard" = {
      repeat-interval = mkUint32 30;
      delay = mkUint32 175;
    };
    "org/gnome/mutter".edge-tiling = false;
    "org/gnome/shell/overrides".edge-tiling = false;
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = mkInt32 (6 * 60 * 60);
      sleep-inactive-ac-type = "suspend";
    };
    "org/gnome/desktop/screensaver".lock-delay = mkUint32 (4 * 60 * 60);
  };
}
