{ config, pkgs, ... }:

{
  imports = [
    ./programs/kitty.nix
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

  programs.vim = {
    enable = true;
    # plugins = with pkgs.vimPlugins; [ vim-monokai-pro oceanic-next fzf-vim undotree ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
      let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
      if empty(glob(data_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
      endif

      call plug#begin('~/.vim/plugged')
              Plug 'Mcmartelle/vim-monokai-bold'
              Plug 'sickill/vim-monokai'
              Plug 'mhartington/oceanic-next'
              Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
              Plug 'mbbill/undotree'
              Plug 'miyase256/vim-ripgrep', {'branch': 'fix/remove-complete-from-RgRoot'}
      call plug#end()

      "Leader Keybindings:"

          let mapleader = " "
          let g:oceanic_next_terminal_bold = 1
          colorscheme OceanicNext
          " set termguicolors
          syntax on
          set nu
          set cursorline

      " Open tab
          map <leader>pi :PlugInstall<cr>
          map <leader>pc :PlugClean<cr>
          map <leader>o :so ~/.vimrc<cr>

      " Open FZF
          nnoremap <leader>f :FZF<cr>
      " Open RG
          nnoremap <leader>r  :Rg<cr>
          nnoremap <leader>rg :Rg

      " Open Undo Tree
          map <leader>ut :UndotreeToggle<cr>

      " Open tab
          map <leader>t :tabnew<cr>
      " Split screen
          nnoremap <leader>s :split<cr>
          nnoremap <leader>vs :vsplit<cr>
      " Split screen and resize 55
          nnoremap <leader>ss :wincmd v<bar> :Ex <bar> :vertical resize 55<CR>
      " Saves the file.
          map <leader>w :w<cr>
      " Saves the file with force.
          map <leader>W :w!<cr>
      " Quits vim.
          map <leader>q :q<cr>
      " Quits vim with force.
          map <leader>Q :q!<cr>

      " Autoread.(editor)
          map <leader>a :e<cr>
      " Resize vertical windows
          nnoremap <Leader>+ :vertical resize +5<CR>
          nnoremap <Leader>- :vertical resize -5<CR>
      " ; for :
          nnoremap ; :
          nnoremap ; :

      " Go to tab by number
          noremap <leader>1 1gt
          noremap <leader>2 2gt
          noremap <leader>3 3gt
          noremap <leader>4 4gt
          noremap <leader>5 5gt
          noremap <leader>6 6gt
          noremap <leader>7 7gt
          noremap <leader>8 8gt
          noremap <leader>9 9gt
          noremap <leader>0 :tablast<cr>

          set nocompatible
      " format
          set autoindent
          set backup
          set nu
          set smartindent
          set showmatch
          set textwidth=80
          set title
          set tabstop=4
          set shiftwidth=4
          set softtabstop=4
          set expandtab
       " files
          filetype on
          filetype indent on
          filetype plugin on
       " always show file name
          set modeline
          set ls=2

          " undo
          set undofile
          set undodir=~/.vim/undodir-vim
          set undolevels=1000
          set undoreload=10000
          set noswapfile

          " RG
          "

    '';
  };

  programs.fish = {
    enable = true;
    shellInit = builtins.readFile /home/marcel/.config/fish/prenix-config.fish;
    plugins = [
      {
        name = "foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
          sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
        };
      }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
      {
        name = "base16-fish";
        src = pkgs.fetchFromGitHub {
          owner = "tomyun";
          repo = "base16-fish";
          rev = "2f6dd973a9075dabccd26f1cded09508180bf5fe";
          sha256 = "142fmqm324gy3qsv48vijm5k81v6mw85ym9mmhnvyv2q2ndg5rix";
        };
      }
      {
        name = "bang-bang";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-bang-bang";
          rev = "f969c618301163273d0a03d002614d9a81952c1e";
          sha256 = "1r3d4wgdylnc857j08lbdscqbm9lxbm1wqzbkqz1jf8bgq2rvk03";
        };
      }
      {
        name = "nvm";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "nvm.fish";
          rev = "81170ef5bc127af4622aa456122c77f363f247bc";
          sha256 = "0ra0yj8nksza1j84l5v5063w0cyxwwb7sxqggf2rlh3i3j77ldz6";
        };
      }
      {
        name = "nvm";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "nvm.fish";
          rev = "81170ef5bc127af4622aa456122c77f363f247bc";
          sha256 = "0ra0yj8nksza1j84l5v5063w0cyxwwb7sxqggf2rlh3i3j77ldz6";
          fetchSubmodules = true;
        };
      }
      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "2fd3d2157d5271ca3575b13daec975ca4c10577a";
          sha256 = "0mb01y1d0g8ilsr5m8a71j6xmqlyhf8w4xjf00wkk8k41cz3ypky";
        };
      }
    ];
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "21.05";
  home.stateVersion = "20.09";
}
