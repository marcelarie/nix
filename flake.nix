{
  description = "Marcel's darwin system flake";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    stable.url = github:nixos/nixpkgs/nixos-21.11;

    home-manager.url = github:nix-community/home-manager/master;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;

    darwin.url = github:lnl7/nix-darwin/master;
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = github:nix-community/neovim-nightly-overlay;
    spacebar.url = github:cmacrae/spacebar/v1.4.0;
  };

  outputs =
    inputs @ { self
    , nur
    , nixpkgs
    , stable
    , darwin
    , home-manager
    , spacebar
    , neovim-nightly-overlay
    ,
    }:
    let
      username = "m.manzanares";
      system = "aarch64-darwin";
      hostname = "mmanzanares-MacBook-Pro";
      pkg-sets = final: prev: {
        stable =
          import inputs.stable
            { system = final.system; };
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
        };
        overlays = [
          pkg-sets
          nur.overlay
          spacebar.overlay.aarch64-darwin
          neovim-nightly-overlay.overlay
          # (
          #   import (
          #     let
          #       # rev = "master";
          #       rev = "6a8790f60859a7ba074af3d0bc373813f2eac15b"; # neovim 8 working rev
          #     in
          #       builtins.fetchTarball {
          #         url = "https://github.com/nix-community/neovim-nightly-overlay/archive/${rev}.tar.gz";
          #       }
          #   )
          # )
        ];
      };
      configuration = { pkgs, ... }: {
        nix.package = pkgs.nixFlakes;
        services.nix-daemon.enable = true;
      };
    in
    {
      darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
        inherit pkgs system;
        modules = [
          ./common.nix
          # ./programs/tmux.nix
          ./darwin-configuration.nix
          # ./yabai-spacebar-skhd.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users."${username}" = {
              # nixpkgs.overlays = pkgs.overlays;
              home.stateVersion = "22.05"; # <-- find how to active this and skip kitty 0,24 error
              imports = [
                ./home-manager/home.nix
              ];
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."${hostname}".pkgs;
    };
}
