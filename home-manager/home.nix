{ config, pkgs, ... }:

let
  username = "m.manzanares";
  homeDir = "/Users/m.manzanares";
  customNodePackages = pkgs.callPackage ~/.nixpkgs/home-manager/programs/npm-packages { };
in
{
  imports = [
    ./programs/kitty.nix
    ./programs/fish
    ./programs/vim
    # ./programs/bash
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # services.picom.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  # home.homeDirectory = homeDir;

  nixpkgs.config.allowUnfree = true;

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    withPython3 = true;
    extraConfig = ''luafile ${homeDir}/.config/nvim/nix.init.lua'';

    extraPackages = with pkgs; [
      deno
      texlab
      stylua
      sqlite
      tree-sitter
      rust-analyzer
      sumneko-lua-language-server
      pkgs.rnix-lsp

      perlPackages.PLS
      perl534Packages.PerlTidy
      perl534Packages.PerlCritic
      nodePackages.prettier

      nodePackages.typescript
      nodePackages.intelephense
      nodePackages.vim-language-server
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.dockerfile-language-server-nodejs

      # nur.repos.crazazy.efm-langserver
    ];
  };

  programs.git = {
    enable = true;
    userName = "Marcel Arie";
    userEmail = "googlillo@gmail.com";
    # aliases = { prettylog = "..."; };
    extraConfig = {
      core = {
        editor = "nvim";
      };
      color = {
        ui = true;
      };
      init = {
        defaultBranch = "main";
      };
      # push = { default = "simple"; };
      # pull = { ff = "only"; };
    };
    # ignores = [ ".DS_Store" "*.pyc" ];
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "calochortus-lyallii";
      };
    };
  };

  # xdg.mimeApps = {
  #   enable = true;
  #   # associations.added = {
  #   #   "application/pdf" = [ "org.gnome.Evince.desktop" ];
  #   # };
  #   defaultApplications = {
  #     # "application/pdf" = [ "org.gnome.Evince.desktop" ];
  #     "x-scheme-handler/http" = [ "firefox.desktop" ];
  #     "x-scheme-handler/https" = [ "firefox.desktop" ];
  #   };
  # };

  home.packages = with pkgs;  [
    # plocate
    alacritty
    rustup
    pkg-config
    zoxide
    starship
    exa
    neofetch
    # sxhkd
    # haskellPackages.greenclip
    feh
    skim
    # ponymix
    # unzip
    fzf
    fzy
    bat
    ripgrep
    lua
    lua53Packages.luarocks
    python3
    fd
    sad
    gh
    python3
    nodejs-17_x
    # flameshot
    nixpkgs-fmt
    # slack
    docker-compose
    libnotify
    sysz
    tldr
    nix-prefetch-github
    glow
    # element-desktop
    mitmproxy
    sumneko-lua-language-server
    mpv
    yt-dlp
    pfetch
    # discord
    python39Packages.pynvim
    tridactyl-native
    jq
    # signal-desktop
    (yarn.override { nodejs = null; })
    htop
    mongodb
    mongodb-tools
    nodePackages.speed-test
    nodePackages.pnpm
    fzf
    lf
    cowsay
    # chromium
    # brave
    hugo
    cht-sh
    # clang
    tree-sitter
    manix # nix docs on the cli
    nodePackages.node2nix
    go
    # keepass

    # NUR
    # nur.repos.afreakk.mongosh

    # NODE PACKAGES
    # customNodePackages.cssmodules-language-server

    # polybar
    # chromium
    # leftwm
    # chromium
    # dunst
    # update-systemd-resolved
    # openvpn
    # home-manager
    # fish
    # vim
    # cargo
    # sumneko-lua-language-server
  ];

  programs.java.enable = true;

  # NODE PACKAGES

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
