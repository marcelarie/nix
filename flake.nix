{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    leftwm.url = "github:leftwm/leftwm";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, leftwm, neovim-nightly-overlay }:
    let
      username = "marcel";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          neovim-nightly-overlay.overlay
          leftwm.overlay
        ];
      };
    in
    {
      homeConfigurations = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs username;
          # stateVersion = "21.05";
          homeDirectory = "/home/${username}";
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
          ];
        };
      };
    };
}
