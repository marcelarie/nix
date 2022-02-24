{ config, pkgs, ... }:

{
  imports = [
    ./programs/kitty.nix
    ./programs/fish
    ./programs/vim
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # services.picom.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "marcel";
  home.homeDirectory = "/home/marcel";

  xsession = {
    pointerCursor = {
      package = pkgs.paper-icon-theme;
      name = "Paper";
      size = 38;
    };
  };
  nixpkgs.config.allowUnfree = true;

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    withPython3 = true;
    extraConfig = ''luafile /home/marcel/.config/nvim/nix.init.lua'';

    extraPackages = with pkgs; [
      tree-sitter
      pkgs.rnix-lsp
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.vim-language-server
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.intelephense
      nodePackages.dockerfile-language-server-nodejs
      sumneko-lua-language-server
      texlab
      rust-analyzer
      deno
      stylua
      nodePackages.prettier
      perl534Packages.PerlTidy
      perl534Packages.PerlCritic
      sqlite
    ];
  };

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
    iconTheme = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };
    font = {
      name = "Noto Sans 9.5";
      package = pkgs.noto-fonts;
    };
  };

  xdg.mimeApps = {
    enable = true;
    # associations.added = {
    #   "application/pdf" = [ "org.gnome.Evince.desktop" ];
    # };
    defaultApplications = {
      # "application/pdf" = [ "org.gnome.Evince.desktop" ];
      "x-scheme-handler/http" = [ "firefox" ];
      "x-scheme-handler/https" = [ "firefox" ];
    };
  };

  programs.rofi = {
    enable = true;
    font = "FiraCode 20";
    theme = ~/.config/rofi/themes/slate.rasi;
  };

  home.packages = with pkgs;  [
    nodePackages.speed-test
    nodePackages.pnpm
    fzf
    # sumneko-lua-language-server
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "21.05";
  # home.stateVersion = "20.09";
}
