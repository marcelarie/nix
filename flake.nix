{
  description = "Marcel's darwin system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nur.url = github:nix-community/NUR;

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, darwin, home-manager, neovim-nightly-overlay }:
    let
      username = "m.manzanares";
      pkgs = import nixpkgs {
        # inherit system;
        # config = { allowUnfree = true; };
        overlays = [
          neovim-nightly-overlay.overlay
          # nur.overlay
        ];
      };
      configuration = { pkgs, ... }: {
        nix.package = pkgs.nixFlakes;
        services.nix-daemon.enable = true;
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake ./modules/examples#simple \
      #       --override-input darwin .

      darwinConfigurations."bcn-marcel-marnzanares" = darwin.lib.darwinSystem {
        modules = [
          ./darwin-configuration.nix
        ];
        system = "x86_64-darwin";
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."bcn-marcel-marnzanares".pkgs;

      # homeConfigurations = {
      #   ${username} = home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs username;
      #     stateVersion = "21.05";
      #     homeDirectory = "/Users/${username}";
      #     system = "x86_64-darwin";
      #     useUserPackages = true;
      #     configuration = {
      #       imports = [
      #         ./home-manager/home.nix
      #       ];
      #     };
      #   };
      # };
      #
      # homeManagerCommonConfig = with self.homeManagerModules; {
      #     inherit pkgs username;
      #   imports = [
      #     ./home-manager/home.nix
      #   ];
      # };

      homeManagerModules = {
        inherit overlays;
        pkgs.overlays = overlays;
      };

    };
}
