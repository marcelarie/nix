## my personal nix config

- to use this configuration

```
nixos-rebuild switch --flake <this_configuration_path>
```

## TO-Do's

- [ ] fix `shopt` error in zsh with `setopt`

## Notes

- Direct overlay:

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

### Useful commands

Disable protection on macOS
`sudo spctl --master-disable` 

