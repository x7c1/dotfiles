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

  # Smaller pointer than linux.nix's 64 for the laptop's smaller screen.
  dconf.settings."org/gnome/desktop/interface".cursor-size =
    lib.mkForce (mkInt32 48);

  # Built-in JIS keyboard: Caps Lock -> Ctrl, Muhenkan -> Alt, Henkan -> Esc.
  # The custom:* options come from the user XKB rules below, which mutter's
  # libxkbcommon reads from ~/.config/xkb alongside the system rules.
  dconf.settings."org/gnome/desktop/input-sources".xkb-options = [
    "ctrl:nocaps"
    "custom:muhenkan_alt"
    "custom:henkan_esc"
  ];

  xdg.configFile."xkb/rules/evdev".text = ''
    ! option = symbols
      custom:muhenkan_alt = +custom(muhenkan_alt)
      custom:henkan_esc   = +custom(henkan_esc)

    ! include %S/evdev
  '';

  xdg.configFile."xkb/symbols/custom".text = ''
    partial modifier_keys
    xkb_symbols "muhenkan_alt" {
        replace key <MUHE> { [ Alt_L ] };
        modifier_map Mod1 { <MUHE> };
    };

    partial function_keys
    xkb_symbols "henkan_esc" {
        replace key <HENK> { [ Escape ] };
    };
  '';

  # Tap Left Shift for direct input, Right Shift for Mozc; Fcitx5 fires
  # modifier-only hotkeys on release when no other key was pressed. Only the
  # global config is managed; the input method list (profile) stays editable
  # in fcitx5-configtool. AltTriggerKeys defaults to Shift_L, so clear it.
  # AllowOverrideXKB=False keeps Fcitx5 from writing its group layout into
  # org.gnome.desktop.input-sources: its first-run profile defaults to
  # keyboard-us, which would replace the jp source set in linux-japanese.nix.
  # force: Fcitx5 writes this file on first run, which would otherwise block
  # activation.
  xdg.configFile."fcitx5/config" = {
    force = true;
    text = ''
      [Hotkey]
      AltTriggerKeys=

      [Hotkey/ActivateKeys]
      0=Shift_R

      [Hotkey/DeactivateKeys]
      0=Shift_L

      [Behavior]
      AllowOverrideXKB=False
    '';
  };
}
