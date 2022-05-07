{
  description = "Marcel's darwin system flake";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;

    home-manager.url = github:nix-community/home-manager/master;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;

    darwin.url = github:lnl7/nix-darwin/master;
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    nur,
    nixpkgs,
    darwin,
    home-manager,
    neovim-nightly-overlay,
  }: let
    username = "m.manzanares";
    system = "x86_64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
      overlays = [
        nur.overlay
        neovim-nightly-overlay.overlay
        # (self: super: { bashInteractive = super.bashInteractive_5; })
        # (
        #   import (
        #     let
        #       rev = "master";
        #       # rev = "10e7407aa9e687bad3e167c46d2efd15eef47673"; # neovim 7 working rev
        #       # rev = "3edbbcf631a94557c3bc599ec270c1cfe01a27d2"; # neovim 8 working rev
        #     in
        #       builtins.fetchTarball {
        #         url = "https://github.com/nix-community/neovim-nightly-overlay/archive/${rev}.tar.gz";
        #       }
        #   )
        # )
      ];
    };
    configuration = {pkgs, ...}: {
      nix.package = pkgs.nixFlakes;
      services.nix-daemon.enable = true;
    };
  in {
    darwinConfigurations."bcn-marcel-manzanares" = darwin.lib.darwinSystem {
      inherit pkgs system;
      modules = [
        ./darwin-configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          home-manager.users."m.manzanares" = {
            # nixpkgs.overlays = pkgs.overlays;
            # home.stateVersion = "22.05"; # <-- find how to active this and skip kitty 0,24 error
            imports = [./home-manager/home.nix];
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."bcn-marcel-manzanares".pkgs;
  };
}
