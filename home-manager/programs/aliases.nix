{
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
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  cat = "bat";

  so = "source ~/.config/fish/config.fish";

  #### Manjaro ####
  # pacmi = "sudo pacman-mirrors --fasttrack && sudo pacman -Syyu";
  #### Pacman ####
  # pac = "sudo pacman -S";
  # pacr = "sudo pacman -Rns";
  # pyyu = "sudo pacman -Syyu";
  # pacu = "sudo pacman -Su";

  #### Server ####
  govh = "ssh marcel@135.125.234.60";

  #### Personal Git ####
  gb = "git checkout (git branch | fzy | xargs)";
  gbde = "git branch -D (git branch | fzy | xargs)";
  gstp = "git status --porcelain | awk 'match($1, 'M'){ print $2 }' | paste -sd ' '";
  grs = "git restore";
  grsa = "git restore *";
  grss = "git restore --staged";
  grssa = "git restore --staged *";
  # glom = "git pull origin (git branch -rl \"*/HEAD\" | rev | cut -d/ -f1 | rev)";
  glof = "git log --oneline -M --stat --follow --";
  gstal = "git stash list";
  # grec = "git log --graph --oneline --decorate ( git fsck --no-reflog | awk \";/dangling commit/ {print $3}\" )";
  gstapp = "git stash apply";
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
  yb = "yarn build";
  ybd = "yarn build:dev";
  yig = "yarn install -g";

  #### Configs ####
  zrc = "nvim ~/.zshrc";
  arc = "nvim ~/.config/alacritty/alacritty.yml";
  drc = "cd ~/.config/arco-dwm & nvim config.h";
  frc = "nvim ~/.config/nixos/home-manager/programs/fish/default.nix";
  krc = "nvim ~/.config/nixos/home-manager/programs/kitty.nix";
  brc = "nvim ~/.config/nixos/home-manager/programs/bash/default.nix";
  lrc = "cd ~/.config/leftwm & nvim config.toml";
  clones = "~/clones";
  dots = "vi ~/.gitignore";

  #### Nvim ####
  vi = "nvim";
  bi = "nvim -c 'colorscheme OceanicNext'";
  mi = "nvim -u ~/.config/nvim/minimal-init.lua";
  #  mi = ";nvim -c "colorscheme monarized""
  revi = "bash ~/scripts/install-last-neovim.sh";
  rc = "nvim ~/.config/nvim/nix.init.*";
  gorc = "cd ~/.config/nvim/";

  #### Docker ####
  # do = "\docker";
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
  # env = "printenv | fzy"; # scripts selector
  nm = "mw -Y && neomutt"; # refresh and open neomutt
  mc = "mcfly search";
  own = "zyc /home/marcel/clones/own";
  learn = "zyc /home/marcel/clones/learning";
  fork = "zyc /home/marcel/clones/forks";
  work = "zyc /home/marcel/clones/work";
  locate = "plocate";
  # klay  =  "setxkbmap (printf \" es\nus\nus (dvorak)\nes (dvorak)\n " | fzy)";
  af = "xdotool type --delay 0 ( alias | fzy | awk -F' ' '{print $2}')";
  chs = "cht.sh";
  fm = "~/clones/forks/fetch-master-6000/fm6000.pl";

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

  ### Custom Tools ###
  glows = "ls *.md | entr -c glow";

  ### NixOS ###
  ns = "nix-shell";
  nfs = "sudo nixos-rebuild switch --flake ~/.config/nixos#";
  nfu = "nix flake update ~/.config/nixos/";
  nrc = "nvim ~/.config/nixos/configuration.nix";
  nfrc = "nvim ~/.config/nixos/flake.nix";
  #-> ### Home Manager  ###
  hrc = "nvim ~/.config/nixos/home-manager/home.nix";
  # hms = "cd ~/.config/nixos/; home-manager switch --flake .";
  # hmsb = "cd ~/.config/nixos/; home-manager build --flake .";

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
  npmls = "npm list -g | grep -o '\\s.*' | tr -d '\\n' | sed 's/\\n+|\\r|⏎//g'";

  # ≃≃≃≃≃≃≃ #
  #   ZSH   #
  # ≃≃≃≃≃≃≃ #
  #  cry\$ = "curl rate.sx"
  #  scd = "f(){sh ~/scripts/"$argv"(ls ~/scripts/"$argv"/ | fzy)};
  #  fzf = "fzf --preview "([[ -f {} ]] && (bat --style = numbers --color = always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200""
  luamake = "/home/marcel/.config/nvim/language-servers/lua-language-server/3rd/luamake/luamake";

  # ≃≃≃≃≃≃≃ #
  #   GIT   #
  # ≃≃≃≃≃≃≃ #
  g = "git";
  ga = "git add";
  gaa = "git add --all";
  gapa = "git add --patch";
  # gb = "git branch";
  gba = "git branch -a";
  # gbda = "git branch --no-color --merged | command grep -vE "^(\*|\s * (master|develop|dev)\s * $)" | command xargs -n 1 git branch -d";
  gbl = "git blame -b -w";
  gbnm = "git branch --no-merged";
  gbr = "git branch --remote";
  gbs = "git bisect";
  gbsb = "git bisect bad";
  gbsg = "git bisect good";
  gbsr = "git bisect reset";
  gbss = "git bisect start";

  gc = "git commit -v";
  "gc!" = "git commit -v --amend";
  "gcn!" = "git commit -v --no-edit --amend";
  "gca" = "git commit -v -a";
  "gca!" = "git commit -v -a --amend";
  "gcan!" = "git commit -v -a --no-edit --amend";
  "gcans!" = "git commit -v -a -s --no-edit --amend";
  gcam = "git commit -a -m";
  gcb = "git checkout -b";
  gcf = "git config --list";
  gcl = "git clone --recursive";
  gclean = "git clean -fd";
  gpristine = "git reset --hard & git clean -dfx";
  gcm = "git checkout master";
  gcmsg = "git commit -m";
  gco = "git checkout";
  gcount = "git shortlog -sn";
  gcp = "git cherry-pick";
  gcs = "git commit -S";

  gd = "git diff";
  gds = "git diff --staged";
  gdca = "git diff --cached";
  gdct = "git describe --tags `git rev-list --tags --max-count 1`";
  gdt = "git diff-tree --no-commit-id --name-only -r";
  gdw = "git diff --word-diff";

  gf = "git fetch";
  gfa = "git fetch --all --prune";
  gfo = "git fetch origin";

  gg = "git gui citool";
  gga = "git gui citool --amend";
  ggpull = "git pull origin (current_branch)";

  ggpush = "git push origin (current_branch)";
  gpsup = "git push --set-upstream origin (current_branch)";
  ggsup = "git branch --set-upstream-to origin (current_branch)";

  gignore = "git update-index --assume-unchanged";
  # gignored = "git ls-files -v | grep "^[ [ :lower: ] ] "";
  git-svn-dcommit-push = "git svn dcommit & git push github master:svntrunk";

  gk = "\gitk --all --branches";
  gke = "\gitk --all (git log -g --pretty format:%h)";

  gl = "git pull";
  glg = "git log --stat";
  glgp = "git log --stat -p";
  glgg = "git log --graph";
  glgga = "git log --graph --decorate --all";
  glgm = "git log --graph --max-count 10";
  glo = "git log --oneline --decorate";
  glol = "git log --graph --pretty format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
  glola = "git log --graph --pretty format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all";
  glog = "git log --oneline --decorate --graph";
  gloga = "git log --oneline --decorate --graph --all";

  gm = "git merge";
  gmom = "git merge origin/master";
  gmt = "git mergetool --no-prompt";
  gmtvim = "git mergetool --no-prompt --tool vimdiff";
  gmum = "git merge upstream/master";

  gp = "git push";
  gpd = "git push --dry-run";
  gpoat = "git push origin --all & git push origin --tags";
  gpu = "git push upstream";
  gpv = "git push -v";

  gr = "git remote";
  gra = "git remote add";
  grb = "git rebase";
  grba = "git rebase --abort";
  grbc = "git rebase --continue";
  grbi = "git rebase -i";
  grbm = "git rebase master";
  grbs = "git rebase --skip";
  grh = "git reset HEAD";
  grhh = "git reset HEAD --hard";
  grmv = "git remote rename";
  grrm = "git remote remove";
  grset = "git remote set-url";
  grt = "cd (git rev-parse --show-toplevel || echo \".\")";
  gru = "git reset --";
  grup = "git remote update";
  grv = "git remote -v";

  gsb = "git status -sb";
  gsd = "git svn dcommit";
  gsi = "git submodule init";
  gsps = "git show --pretty short --show-signature";
  gsr = "git svn rebase";
  gss = "git status -s";
  gst = "git status";
  gs = "git status";
  gsta = "git stash save";
  gstaa = "git stash apply";
  gstd = "git stash drop";
  gstl = "git stash list";
  # gstp = "git stash pop";
  gsts = "git stash show --text";
  gsu = "git submodule update";

  gts = "git tag -s";
  gtv = "git tag | sort -V";

  gunignore = "git update-index --no-assume-unchanged";
  gunwip = "git log -n 1 | grep -q -c \"\ - \-wip\ - \-\" & git reset HEAD~1";
  gup = "git pull --rebase";
  gupv = "git pull --rebase -v";
  glum = "git pull upstream master";

  gwch = "git whatchanged -p --abbrev-commit --pretty medium";
  gwip = "git add -A; git rm (git ls-files --deleted) 2> /dev/null; git commit -m \"--wip--\"";

}
