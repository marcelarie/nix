{ pkgs, config, lib, ... }:

with lib;
{
  config.programs.fish = {
    enable = true;
    shellInit = builtins.readFile /home/marcel/.config/fish/prenix-config.fish;
    shellAliases = {
      ls = "exa --git";
      l = "ls";
      cp = "cp -i"; # Confirm before overwriting something
      mv = "mv -i"; # Confirm before overwriting something
      rm = "rm -i"; # Confirm before overwriting something
      df = "df -h"; # Human-readable sizes
      free = "free -m"; # Show sizes in MB

      grep = "grep --colour = auto";
      egrep = "egrep --colour = auto";
      fgrep = "fgrep --colour = auto";
      # ..  =  "cd ..";
      # ...  =  "cd ../..";
      # ...  =  "cd ../../..";
      cat = "bat";

      so = "source ~/.config/fish/prenix-config.fish";

      #### Manjaro ####
      pacmi = "sudo pacman-mirrors --fasttrack && sudo pacman -Syyu";

      #### Pacman ####
      pac = "sudo pacman -S";
      pacr = "sudo pacman -Rns";
      pyyu = "sudo pacman -Syyu";
      pacu = "sudo pacman -Su";

      #### Server ####
      govh = "ssh marcel@135.125.234.60";

      #### Personal Git ####
      gb = "git checkout (git branch | fzy | xargs)";
      gbde = "git branch -D (git branch | fzy | xargs)";
      # gstp = "git status --porcelain | awk \"match($1, \"M\"){ print $2 }\" | paste -sd \" \"";
      grs = "git restore";
      grsa = "git restore *";
      grss = "git restore --staged";
      grssa = "git restore --staged *";
      glom = "git pull origin (git branch -rl \"*/HEAD\" | rev | cut -d/ -f1 | rev)";
      glof = "git log --oneline -M --stat --follow --";
      gstal = "git stash list";
      grec = "git log --graph --oneline --decorate ( git fsck --no-reflog | awk \";/dangling commit/ {print $3}\" )";
      gstapp = "git stash apply";
      #  gld = "git fetch && git log --color -p --full-diff (git rev-parse --abbrev-ref HEAD)..origin/(git rev-parse --abbrev-ref HEAD) && git pull";
      gw = "git worktree";
      gwa = "git worktree add";
      gwl = "git worktree list";
      gwp = "git worktree prune";
      gwr = "git worktree remove";

      #### Develop ####
      ys = "yarn start";
      yu = "yarn update";
      yi = "yarn install";
      ya = "yarn add";
      yig = "yarn install -g";

      #### Configs ####
      zrc = "nvim ~/.zshrc";
      arc = "nvim ~/.config/alacritty/alacritty.yml";
      drc = "cd ~/.config/arco-dwm & nvim config.h";
      frc = "nvim ~/.config/fish/prenix-config.fish";
      sfrc = "source ~/.config/fish/config.fish";
      krc = "nvim ~/.config/kitty/kitty.conf";
      brc = "nvim ~/.bashrc";
      lrc = "cd ~/.config/leftwm & nvim config.toml";
      clones = "~/clones";
      dots = "vi ~/.gitignore";

      #### Nvim ####
      vi = "nvim";
      bi = "nvim -c 'colorscheme OceanicNext'";
      mi = "nvim -u ~/.config/nvim/minimal-init.lua";
      #  mi = ";nvim -c "colorscheme monarized""
      revi = "bash ~/scripts/install-last-neovim.sh";
      rc = "nvim ~/.config/nvim/init.*";
      gorc = "cd ~/.config/nvim/";

      #### Docker ####
      do = "docker";
      dor = "docker run";
      dob = "docker build";
      dos = "docker stop";
      dosp = "docker system prune -a && docker volume prune";
      dorai = "docker rmi (docker images -a -q)";
      doraif = "docker rmi -f (docker images -a -q)";
      doex = "docker exec -it";

      dc = "docker-compose";
      dcp = "docker-compose ps";
      dcr = "docker-compose rm";
      dcu = "docker-compose up";
      dcl = "docker compose logs -f";

      #### Others ####
      hist = "xdotool type --delay 0 (history | fzy -l 20)";
      live-server = "live-server --no-browser";
      pt = "vi ~/personal/tasks";
      gopt = "cd ~/personal/tasks";
      wbcn = "curl wttr.in/Barcelona\?0Q";
      create-react-app = "create-react-app --template mini";
      gmod = "git ls-files -m";
      ytmp3 = "youtube-dl --extract-audio --audio-format mp3";
      xyy = "xsel --clipboard --input";
      xp = "xsel --clipboard --output";
      node15 = "source /usr/share/nvm/init-nvm.sh";
      scp = "sh ~/scripts/(ls ~/scripts/ | fzy)"; # scripts selector
      env = "printenv | fzy"; # scripts selector
      nm = "mw -Y && neomutt"; # refresh and open neomutt
      mc = "mcfly search";
      own = "zyc /home/marcel/clones/own";
      learn = "zyc /home/marcel/clones/learning";
      fork = "zyc /home/marcel/clones/forks";
      work = "zyc /home/marcel/clones/work";
      locate = "plocate";
      # klay  =  "setxkbmap (printf \" es\nus\nus (dvorak)\nes (dvorak)\n " | fzy)";
      # af = "xdotool type --delay 0 (  | fzy | awk -F\" \" \"{print $2}\")";

      #### Tmux ####
      #  t = "tmux attach || tmux new-session" # Attaches tmux to the last session; creates a new session if none exists.
      ta = "tmux attach -t"; # Attaches tmux to a session (example: ta portal)
      tn = "tmux new-session"; # Creates a new session
      tl = "tmux list-sessions"; # Lists all ongoing sessions
      ts = "tmux switch -t (tmux ls | cut -f1 -d\":\" | fzy)";

      #### Rust ####
      cn = "cargo new";
      ca = "cargo add";
      cr = "cargo run";
      cb = "cargo build";
      cu = "cargo update";
      ciu = "cargo install-update -a";
      ci = "cargo install";
      cdo = "cargo doc --open";
      cw = "cargo watch -x run";
      cpub = "cargo publish";
      ctd = "cargo tree -d";

      ### NixOS ###
      #  nrs = "sudo nixos-rebuild switch -I nixos-config = /home/marcel/.config/nixos/configuration.nix"
      #  nhs = "sudo nixos-rebuild switch -I nixos-config = /home/marcel/.config/nixos/configuration.nix && home-manager switch"
      nrs = "sudo nixos-rebuild switch --flake ~/.config/nixos#";
      nrb = "nix build ~/.config/nixos#homeManagerConfigurations.marcel.activationPackage";
      nrc = "nvim ~/.config/nixos/configuration.nix";
      nfrc = "nvim ~/.config/nixos/flake.nix";
      nfu = "nix flake update ~/.config/nixos/";
      hms = "home-manager switch";
      hmrc = "nvim ~/.config/nixos/home-manager/home.nix";

      ### Cheat ###
      ch = "cheat";
      che = "cheat -e";
      chl = "cheat (cheat -l | cut -f1 -d \" \" | fzy)";

      ### Ctags ###
      ctag = "ctags --recurse = yes";
      #  t = "vi -t "(cut -f1 tags | tail +7 | uniq | fzf)""

      ### SoySuper ###
      #  re.pl = "echo "source ~/.zshrc && re.pl" | zsh"
      dz = "zsh -c \" source ~/.zshrc; # dzil build; cpanm --auto-cleanup 0.0001 -n *.tar.gz; dzil clean\" ";
      sdw = "time sc deploy workers";
      sdm = "time sc deploy manager";
      logcli = "logcli --addr=\"http://monitor-0.ss:3100\"";
      sup = "cd ~/clones/work/supers/";
      prove = "provewatcher";
      gpdw = "git push && sc deploy workers";

      ### Arco ###
      update-grub = "sudo grub-mkconfig -o /boot/grub/grub.cfg";
      hibernate = "sudo systemctl hibernate";
      hybridsleep = "sudo systemctl hybrid-sleep";

      ### Own ###
      #  gtm = "$HOME/clones/own/git-tellme/target/release/gtm"
      #  gtm = "$HOME/clones/own/git-tellme/target/release/gtm"
      npmls = "npm list -g | grep -o \"\s.*\" | tr -d \"\n\" | sed \"s/\n+|\r|⏎//g\"";

      # ≃≃≃≃≃≃≃≃≃≃≃≃≃≃ #
      #   ZSH  TODO:   #
      # ≃≃≃≃≃≃≃≃≃≃≃≃≃≃ ⩨

      #  cry\$ = "curl rate.sx"
      #  scd = "f(){sh ~/scripts/"$argv"(ls ~/scripts/"$argv"/ | fzy)};
      #  fzf = "fzf --preview "([[ -f {} ]] && (bat --style = numbers --color = always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200""
    };
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
}
