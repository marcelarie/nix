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

rust example:
- this generates a `nix-shell` that can run the `gtm` binary:

```nix 
with import <nixpkgs> { };
let
  gtm =
    rustPlatform.buildRustPackage
      rec {
        pname = "git-tellme";
        version = "684d04c8f1463560a291fb6521070ce5c38c1138";

        src = fetchFromGitHub {
          owner = "marcelarie";
          repo = pname;
          rev = version;
          sha256 = "FBuviHXWfvnZh/68qyDNlJatb/aHjmOszL1uS5W4IMQ=";
        };
        nativeBuildInputs = [ pkg-config ];
        buildInputs = [ openssl ];

        cargoSha256 = "UYTlhV95GYFOFPZ15fsHlWBwp/guCe8yh7JiJB/AVwE=";
      };
in
mkShell
{
  name = "git-tellme";
  buildInputs = [ gtm redis ];
}
```
