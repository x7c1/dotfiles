{ pkgs, config, ... }:
{
  # Skip direnv's checkPhase on darwin: `make test-bash test-zsh` invokes
  # direnv allow/deny which expect a tty, and the darwin sandbox build has
  # none, so the zsh test hangs indefinitely.
  programs.direnv.package = pkgs.direnv.overrideAttrs (_: {
    doCheck = false;
  });

  targets.darwin.defaults = {
    NSGlobalDomain = {
      # Unit: 1/60 sec ticks (~16.67ms), not ms.
      KeyRepeat = 2;          # ~33ms (GUI minimum)
      InitialKeyRepeat = 12;  # ~200ms (below GUI's 15-step / 250ms floor)
    };
  };

  # Out-of-store symlink so Karabiner-Elements GUI writes through to the
  # repo file (same pattern as nvim/lazy-lock.json in shared.nix). The path
  # goes via ~/.config/home-manager (a symlink to the dotfiles checkout) so
  # the actual repo location can vary per machine.
  xdg.configFile."karabiner/karabiner.json".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/home-manager/../macos/karabiner/karabiner.json";

  # Same out-of-store symlink for VS Code keybindings. On macOS VS Code reads
  # them from ~/Library/Application Support (not ~/.config), so this lives in
  # home.file rather than xdg.configFile. Points at the same shared repo file
  # as linux.nix, so the bindings stay in sync across machines.
  home.file."Library/Application Support/Code/User/keybindings.json".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/home-manager/../config/vscode/keybindings.json";
}
