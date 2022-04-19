{
  description = "Marcel's darwin system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    # spacebar.url = "github:cmacrae/spacebar/v1.4.0";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    nur,
    nixpkgs,
    darwin,
    home-manager,
    # , spacebar
    neovim-nightly-overlay,
  }: let
    username = "m.manzanares";
    pkgs = import nixpkgs {
      # inherit system;
      # config = { allowUnfree = true; };
      overlays = [
        nur.overlay
        # neovim-nightly-overlay.overlay
        (
          import (
            let
              rev = "master";
              # neovim 7 working rev
              # rev = "10e7407aa9e687bad3e167c46d2efd15eef47673";
            in
              builtins.fetchTarball {
                url = "https://github.com/nix-community/neovim-nightly-overlay/archive/${rev}.tar.gz";
              }
          )
        )
      ];
    };
    configuration = {pkgs, ...}: {
      nix.package = pkgs.nixFlakes;
      services.nix-daemon.enable = true;
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake ./modules/examples#simple \
    #       --override-input darwin .

    darwinConfigurations."bcn-marcel-manzanares" = darwin.lib.darwinSystem {
      inherit pkgs;
      system = "x86_64-darwin";
      modules = [
        ./darwin-configuration.nix
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."bcn-marcel-manzanares".pkgs;
  };
}
