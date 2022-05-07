# Use a custom configuration.nix location.
# $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
# environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";
{
  config,
  pkgs,
  ...
}: {
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

  nix.binaryCaches = ["https://cache.nixos.org/" "https://nix-node.cachix.org/"];

  environment.systemPackages = with pkgs; [
    gcc
    cmake
    bind
  ];

  environment.variables = {
    SYS_THEME = "dark";
    VI_CONFIG = "~/.config/nvim/init.vim";
  };

  # fonts.fonts = with pkgs; [
  #   noto-fonts
  #   noto-fonts-cjk
  #   noto-fonts-emoji
  #   nerdfonts
  # ];

  # programs.zsh.enable = true; # default shell on catalina
  programs.fish.enable = true;

  system.stateVersion = 4;
}