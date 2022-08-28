{ pkgs
, config
, lib
, ...
}: {
  config.programs.bash = {
    enable = true;
    # bashrcExtra = builtins.readFile ./bashrc;
    # profileExtra = builtins.readFile ./profile;
    shellAliases = import ../aliases.nix;
  };
}
