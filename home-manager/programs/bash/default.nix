{
  pkgs,
  config,
  ...
}: {
  config.programs.bash = {
    enable = true;
    shellAliases = import ../aliases.nix;
    bashrcExtra = builtins.readFile ./bashrc;
    profileExtra = builtins.readFile ./profile;
  };
}
