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

  environment.systemPackages = with pkgs;
    [
        kitty
        tree-sitter
        gh
        fzf
        ripgrep
        delta
        fd
        sad
    ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    # nerdfonts
  ];

  home-manager = {
    useUserPackages = true;
    users."m.manzanares" = (import ./home-manager/home.nix );
  };

  programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;

  system.stateVersion = 4;
}
