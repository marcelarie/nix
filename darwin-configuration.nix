{ config
, pkgs
, ...
}: {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      keep-outputs = true
      auto-optimise-store = true
      extra-platforms = x86_64-darwin aarch64-darwin
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.registry."node".to = {
    type = "github";
    owner = "andyrichardson";
    repo = "nix-node";
  };

  nix.binaryCaches = [ "https://cache.nixos.org/" "https://nix-node.cachix.org/" ];

  system.stateVersion = 4;
}