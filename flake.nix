{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    leftwm.url = "github:leftwm/leftwm";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, leftwm, neovim-nightly-overlay }:
    let
      me = "marcel";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      overlays = [
        leftwm.overlay
        neovim-nightly-overlay.overlay
      ];
      lib = nixpkgs.lib;
    in
    {
      homeManagerConfigurations = {
        ${me} = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = me;
          stateVersion = "21.05";
          homeDirectory = "/home/${me}";
          configuration = {
            nixpkgs.overlays = overlays;
            imports = [
              ./home-manager/home.nix
              # ./home-manager/programs/fish.nix
              # ./home-manager/programs/kitty.nix
            ];
          };
        };
      };

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
          ];
        };
      };

    };
}
