{ config, pkgs, ... }:

# Use a custom configuration.nix location.
# $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
# environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

{
  imports = [ <home-manager/nix-darwin> ];
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

  environment.systemPackages = with pkgs;
    [
      kitty
      gcc
      cmake
      bind
    ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    nerdfonts
  ];

  environment.variables = {
    SYS_THEME = "dark";
    VI_CONFIG = "~/.config/nvim/init.vim";
  };

  home-manager = {
    useUserPackages = true;
    users."m.manzanares" = (import ./home-manager/home.nix);
  };

  programs.zsh.enable = true; # default shell on catalina
  programs.fish.enable = true;

  system.stateVersion = 4;
}
