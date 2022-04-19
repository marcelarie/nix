{
  pkgs,
  config,
  lib,
  ...
}: {
  config.programs.bash = {
    enable = false;
    # bashrcExtra = builtins.readFile ./bashrc;
    profileExtra = builtins.readFile ./profile;
    shellAliases = import ../aliases.nix;
  };
}
