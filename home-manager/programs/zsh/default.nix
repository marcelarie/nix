{
  pkgs,
  config,
  lib,
  ...
}: {
  config.programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./zshrc;
    # profileExtra = builtins.readFile ./profile;
    shellAliases = import ../aliases.nix;
  };
}
