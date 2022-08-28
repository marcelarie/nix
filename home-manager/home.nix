{ config
, pkgs
, ...
}:
let
  username = "m.manzanares";
  homeDir = "/Users/m.manzanares";
  customNodePackages = pkgs.callPackage ./programs/npm-packages { };
in
{
  imports = [
    ./programs/vim
    ./programs/fish
    ./programs/bash
    ./programs/tmux
    ./programs/alacritty
    ./programs/zsh
    ./programs/kitty.nix
  ];

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

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
      texlab
      sqlite
      tree-sitter
      rust-analyzer
      sumneko-lua-language-server

      perlPackages.PLS
      # perl534Packages.PerlTidy
      perl534Packages.PerlCritic
      # nodePackages.prettier
      # nodePackages.prettier_d_slim

      nodePackages.eslint_d
      nodePackages.typescript
      nodePackages.intelephense
      nodePackages.vim-language-server
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.dockerfile-language-server-nodejs
      # customNodePackages.cssmodules-language-server
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
        # syntax-theme = "calochortus-lyallii";
      };
    };
  };

  home.packages = with pkgs; [
    coreutils
    curl
    wget
    alacritty
    rustup
    pkg-config
    zoxide
    starship
    exa
    # neofetch
    neo
    onefetch
    feh
    skim
    fzf
    fzy
    bat
    ripgrep
    lua
    lua53Packages.luarocks
    python
    fd
    sad
    gh
    nodejs
    nixpkgs-fmt
    docker-compose
    libnotify
    sysz
    tldr
    nix-prefetch-github
    glow
    # mitmproxy
    sumneko-lua-language-server
    mpv
    yt-dlp
    pfetch
    python39Packages.pynvim
    tridactyl-native
    jq
    (yarn.override { nodejs = null; })
    htop
    # mongodb
    mongodb-tools
    nodePackages.speed-test
    nodePackages.pnpm
    fzf
    lf
    cowsay
    cht-sh
    tree-sitter
    manix # nix docs on the cli
    nodePackages.node2nix
    go
    helix
    zk
    alejandra
    stylua
    exercism
    shfmt
    bashInteractive
    nodePackages.typescript
    rnix-lsp
    vifm
    pm2
    deno
    tree
    gitlint
    zathura
    # pyright
    black
    python310Packages.flake8
    freshfetch
    obsidian
    perl534Packages.PerlTidy

    #<DISCARDED_PACKAGES>
    # spacebar
    # customNodePackages."@fsouza/prettierd"
    # librsync
    # yabai

    # element-desktop
    # discord
    # signal-desktop
    # slack
    # chromium
    # brave
    # hugo
    # keepass
    # flameshot
    # ponymix
    # unzip
    # sxhkd
    # plocate
    # haskellPackages.greenclip
  ];

  programs.java.enable = true;
}
