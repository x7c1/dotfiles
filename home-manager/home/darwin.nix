{ pkgs, ... }:
{
  # Skip direnv's checkPhase on darwin: `make test-bash test-zsh` invokes
  # direnv allow/deny which expect a tty, and the darwin sandbox build has
  # none, so the zsh test hangs indefinitely.
  programs.direnv.package = pkgs.direnv.overrideAttrs (_: {
    doCheck = false;
  });
}
