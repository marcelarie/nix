{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  config = {
    # Collect nix store garbage and optimise daily.
    nix.gc.user = "root";
    nix.gc.automatic = true;
    nix.gc.options = "--delete-older-than 30d";
    # nix.optimise.automatic = true;

    programs.zsh.enable = true; # default shell on MacOS
    programs.fish.enable = true;

    # environment.systemPackages = with pkgs; [
    #   gcc
    #   cmake
    #   bind
    # ];

    environment.variables = {
      SYS_THEME = "dark";
      VI_CONFIG = "~/.config/nvim/init.vim";
      TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
    };

    fonts.fontDir.enable = true;
    fonts.fonts = with pkgs; [
      font-awesome
      recursive
      (nerdfonts.override {fonts = ["FiraCode"];})
    ];

    system.keyboard.enableKeyMapping = true;
    system.keyboard.remapCapsLockToEscape = true;

    programs.nix-index.enable = true;

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
