{ pkgs, lib, config, ... }:
let
  inherit (lib.hm.gvariant) mkInt32 mkUint32;
in
{
  home.packages = with pkgs; [
    wl-clipboard
    pwgen
  ];

  # Out-of-store symlink so VS Code's GUI writes through to the repo file
  # (same pattern as nvim/lazy-lock.json in shared.nix). On Linux VS Code
  # reads keybindings from ~/.config/Code/User/keybindings.json. Commit the
  # shared bindings; leave experimental, machine-local ones uncommitted.
  xdg.configFile."Code/User/keybindings.json".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/home-manager/../config/vscode/keybindings.json";

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
