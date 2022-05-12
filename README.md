## my personal nix config

- to use this configuration

```
nixos-rebuild switch --flake <this_configuration_path>
```

## Notes

- Direct overlay:

```nix
(
  import (
    let
      rev = "master";
      # rev = "10e7407aa9e687bad3e167c46d2efd15eef47673";
    in
      builtins.fetchTarball {
        url = "https://github.com/nix-community/neovim-nightly-overlay/archive/${rev}.tar.gz";
      }
  )
)
```
