## my personal nix config

#### Use this configuration

```
nixos-rebuild switch --flake <this_configuration_path>
```

## TO-Do's

- [x] fix `shopt` error in zsh with `setopt`

## Notes

#### Direct overlay

```nix
(
  import (
    let
      rev = "master";
      # rev = "10e7407aa9e687bad3e167c46d2efd15eef47673"; # neovim 7 working rev
      # rev = "3edbbcf631a94557c3bc599ec270c1cfe01a27d2"; # neovim 8 working rev
    in
      builtins.fetchTarball {
        url = "https://github.com/nix-community/neovim-nightly-overlay/archive/${rev}.tar.gz";
      }
  )
)
```

#### Disable build tests

```nix
  package = pkgs.kitty.overrideAttrs (old: {
    doChek = false;
    doInstallCheck = false;
  });
```

#### Override examples

```nix
# simple override
    (yarn.override {nodejs = null;})
```

```nix
# override attributes
    (yabai.overrideAttrs {
      version = "4.0.0";
      src = fetchFromGitHub {
        owner = "koekeishiya";
        repo = "yabai";
        rev = "v4.0.0";
        sha256 = "0rxl0in3rhmrgg3v3l91amr497x37i2w1jqm52k0jb9my1sk67rs";
      };
    })
```

```nix
# to inherit old attributes and use `rec`
    (yabai.overrideAttrs (oldAttrs: rec {
      inherit (oldAttrs) pname;
      version = "4.0.0";
      src = fetchFromGitHub
        {
          owner = "koekeishiya";
          repo = pname;
          rev = "v${version}";
          sha256 = "rllgvj9JxyYar/DTtMn5QNeBTdGkfwqDr7WT3MvHBGI=";
        };
    }))
```

## Useful commands

Disable protection on macOS:  
`sudo spctl --master-disable` 

