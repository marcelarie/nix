## my personal nix config

- to use this configuration
```
nixos-rebuild switch --flake <this_configuration_path>
```

### nix env shell example
```nix
with import <nixpkgs> { };
stdenv.mkDerivation
rec {
  name = "env";
  buildInputs = [ nodejs-slim-17_x figlet lolcat ];
  shellHook = ''
    figlet "Welcome!" | lolcat --freq 0.5
  '';
}
```
