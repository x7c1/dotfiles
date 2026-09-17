{ pkgs, lib, ... }:
{
  # Keep the desktop language in English; this host-specific module only adds
  # Japanese input and fonts.
  home.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];

      systemd.enable = true;

      settings.inputMethod = {
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "jp";
          DefaultIM = "mozc";
        };

        "Groups/0/Items/0" = {
          Name = "keyboard-jp";
          Layout = "jp";
        };

        "Groups/0/Items/1" = {
          Name = "mozc";
          Layout = "";
        };
      };
    };
  };

  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # Match the laptop's physical JIS keyboard in GNOME/Wayland as well as in
  # Fcitx5. The desktop language remains English.
  dconf.settings."org/gnome/desktop/input-sources" = {
    sources = [
      (lib.hm.gvariant.mkTuple [ "xkb" "jp" ])
    ];
  };
}
