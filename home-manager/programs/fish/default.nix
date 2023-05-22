{ pkgs, config, lib, ... }:
let
  nixConfig = "~/.nixpkgs";
  home = "/Users/marcelmanzanares2/";
in {
  config.programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./prenix-config.fish;
    functions = {
      mdp = "ls $argv | entr -c glow $argv";
      gld = ''
        set branch (git rev-parse --abbrev-ref HEAD)
        git fetch \
        && git log --color -p --full-diff $branch..origin/$branch \
        && git merge origin/$branch
      '';
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      goo = ''open "https://www.google.com/search?q=$argv" '';
      current_branch = "git symbolic-ref --short HEAD";
      nfs = "sudo darwin-rebuild switch --fallback --flake ~/.nixpkgs# $argv;";
      nsp = "nix-shell -p $argv";
      oat = "${home}scripts/open-ai/oat.sh $argv";
      nvm = "bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv";
      # hms = "cd ~/.config/nixos/; git add --all; home-manager switch --flake . $argv; cd -";
      # hmb = "cd ~/.config/nixos/; git add --all; home-manager build --flake . $argv; cd -";
      trs = ''
        if test -z "$argv"
              curl -s -X GET "https://libretranslate.com/languages" \
                  -H  "accept: application/json"  | jq -j '.[]|"\n", .code, " (",.name, ") "'
            return 1;
        end
          curl -s 'https://libretranslate.de/translate' \
                 -H 'Content-Type: application/json' \
                 -d "{\"q\":\"$argv[1..-3]\",\"source\":\"$argv[-2]\",\"target\":\"$argv[-1]\"}" \
                 | jq .translatedText
      '';
    };
    shellAliases = import ../aliases.nix;
    plugins = [
      {
        name = "fish-abbreviation-tips";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fish-abbreviation-tips";
          rev = "4ff1f565b5773aadba028051f432984def921762";
          sha256 = "fveTvR+T6IiX8Zk5m6zToo1OtZc1VyrCHfOG63e9b64=";
        };
      }
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
      # {
      #   name = "fish-async-prompt";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "acomagu";
      #     repo = "fish-async-prompt";
      #     rev = "4c732cc043b8dd04e64a169ec6bbf3a9b394819f";
      #     sha256 = "YgqZINmY4nKphlqwHo2B0NfP4nmSxIIuAMUuoftI9Lg=";
      #   };
      # }
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
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
