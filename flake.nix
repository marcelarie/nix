{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;

    leftwm.url = "github:leftwm/leftwm";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nur
    , leftwm
    , neovim-nightly-overlay
    }:
    let
      username = "marcel";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          neovim-nightly-overlay.overlay
          leftwm.overlay
          nur.overlay
        ];
      };
    in
    {
      homeConfigurations = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs username;
          homeDirectory = "/home/${username}";
          # stateVersion = "21.05";
          configuration = {
            imports = [
              ./home-manager/home.nix
            ];
          };
        };
      };

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            # ({ config, pkgs, ... }: { nixpkgs.overlays = [ leftwm.overlay ]; })
            ./configuration.nix
            # home-manager.nixosModules.home-manager
            # {
            #   home-manager.useGlobalPkgs = true;
            #   home-manager.useUserPackages = true;
            #   home-manager.users.marcel = import ./home-manager/home.nix;

            #   # Optionally, use home-manager.extraSpecialArgs to pass
            #   # arguments to home.nix
            # }
          ];
        };
      };
    };
}
