{ pkgs
, config
, lib
, ...
}: {
  config.programs.nsh = {
    enable = true;
    # configFile = "";
    # envFile = "";
    # shellAliases = import ../aliases.nix;
  };
}
