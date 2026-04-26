{ pkgs, config, ... }:
{
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "x7c1";
        email = "994424+x7c1@users.noreply.github.com";
      };
      interactive.singlekey = true;
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

    initContent = builtins.concatStringsSep "\n" (map builtins.readFile [
      ../../config/zsh/terminal.zsh
      ../../config/zsh/history.zsh
      ../../config/zsh/fzf.zsh
      ../../config/zsh/fnm.zsh
      ../../config/zsh/tmux-title.zsh
    ]);
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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withRuby = false;
    withPython3 = false;
    extraPackages = with pkgs; [
      tree-sitter
      gcc
      nodejs
    ];
  };

  xdg.configFile = {
    "nvim/init.lua".source = ../../config/nvim/init.lua;
    "nvim/after/plugin/local.lua".source = ../../config/nvim/after/plugin/local.lua;
    "nvim/lua/custom/plugins/completion.lua".source = ../../config/nvim/lua/custom/plugins/completion.lua;

    # Symlink lazy-lock.json directly back to the repo so :Lazy update
    # writes through to the file under git, instead of stranding plugin
    # versions on a single machine. The path goes via ~/.config/home-manager
    # (which is itself a symlink to the dotfiles checkout) so the actual
    # repo location can vary per machine.
    "nvim/lazy-lock.json".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.config/home-manager/../config/nvim/lazy-lock.json";
  };

  programs.tmux = {
    enable = true;
    prefix = "C-t";
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_status_style 'rounded'
          set -g @catppuccin_date_time_text '%Y-%m-%d %a %H:%M'
        '';
      }
    ];
    extraConfig = builtins.readFile ../../config/tmux/tmux.conf;
  };

  home.shellAliases = {
    lg = "lazygit log";
    gst = "git status";
    gd = "git diff";
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    jq
    yq-go
    bat
    tree
    dust
    pwgen
    awscli2
    opentofu
    rustup
    fnm
  ];
}

