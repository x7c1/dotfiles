{ pkgs, lib, ... }:
{
  # Japanese input on this host is deliberately split in two.
  #
  # Fcitx5 and Mozc themselves come from apt (ubuntu/scripts/install-fcitx5.sh):
  # this is not NixOS, so the system GTK/Qt only scan their own immodules cache
  # under /usr/lib, and a Nix-built fcitx5-gtk stays invisible to apt-installed
  # apps such as VS Code. GNOME/Wayland has no zwp_input_method_v2, so Fcitx5
  # has to go through those IM modules rather than a Wayland frontend.
  #
  # What home-manager keeps are the parts that do work from the user profile:
  # fonts, the session variables that point the toolkits at Fcitx5, and GNOME
  # settings. The desktop language stays English.
  home.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.enable = true;

  # Written to ~/.config/environment.d/, which the systemd user session reads,
  # so GUI apps launched from the GNOME overview see these too. home.sessionVariables
  # would only reach shells that source hm-session-vars.sh.
  systemd.user.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # Match the laptop's physical JIS keyboard in GNOME/Wayland as well as in
  # Fcitx5.
  dconf.settings."org/gnome/desktop/input-sources" = {
    sources = [
      (lib.hm.gvariant.mkTuple [ "xkb" "jp" ])
    ];
  };
}
