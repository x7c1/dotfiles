{ pkgs, ... }:
{
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
      name = "x7c1";
      email = "994424+x7c1@users.noreply.github.com";
    };
  };

  programs.lazygit.enable = true;

  home.shellAliases = {
    lg = "lazygit log";
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    jq
  ];
}

