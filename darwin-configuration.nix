{ config
, pkgs
, ...
}: {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };

  services.nix-daemon.enable = true;

  nix.registry."node".to = {
    type = "github";
    owner = "andyrichardson";
    repo = "nix-node";
  };

  nix.binaryCaches = [ "https://cache.nixos.org/" "https://nix-node.cachix.org/" ];

  system.stateVersion = 4;
}
