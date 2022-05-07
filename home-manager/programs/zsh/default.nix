{
  pkgs,
  config,
  lib,
  ...
}: {
  config.programs.bash = {
    enable = true;
    initExtra = builtins.readFile ./zshrc;
    # profileExtra = builtins.readFile ./profile;
    shellAliases = import ../aliases.nix;
  };
}
