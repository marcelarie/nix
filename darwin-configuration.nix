{ config, pkgs, ... }: {
  nix = {
    # package = pkgs.nixFlakes;
    package   = pkgs.nixVersions.stable;
    extraOptions = ''
      keep-outputs = true
      auto-optimise-store = false
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

  nix.settings.substituters =
    [ "https://cache.nixos.org/" "https://nix-node.cachix.org/" ];

  system.stateVersion = 4;
}
