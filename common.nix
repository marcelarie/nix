{ config
, lib
, pkgs
, ...
}:
with lib; {
  config = {
    # Collect nix store garbage and optimise daily.
    nix.gc.user = "root";
    nix.gc.automatic = true;
    nix.gc.options = "--delete-older-than 30d";
    # nix.optimise.automatic = true;

    # programs.zsh.enable = true; # default shell on MacOS
    programs.fish.enable = true;

    environment.systemPackages = with pkgs; [
      gcc
      cmake
      bind
    ];

    environment.variables = {
      SYS_THEME = "dark";
      VI_CONFIG = "~/.config/nvim/init.vim";
    };

    fonts.fonts = with pkgs; [
      font-awesome
    ];

    # environment.shells = with pkgs; [
    # bashInteractive
    # fish
    # zsh
    # "/usr/local/bin/fish"
    # "/usr/local/bin/zsh"
    # "/opt/homebrew/bin/fish"
    # ];
  };
}
