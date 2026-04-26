{ pkgs, ... }:
{
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "vim";
    LANG = "en_US.UTF-8";
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "x7c1";
      email = "994424+x7c1@users.noreply.github.com";
    };
  };

  programs.lazygit.enable = true;

  programs.gh.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";

    history = {
      size = 50000;
      save = 50000;
      share = true;
      ignoreAllDups = true;
    };

    initContent = builtins.readFile ../../config/zsh/init.zsh;
  };

  programs.starship.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.shellAliases = {
    lg = "lazygit log";
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    jq
  ];
}

