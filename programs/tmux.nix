{ config
, lib
, pkgs
, ...
}:
let
  tmuxMenuSeperator = "''";
in
with lib; {
  config.programs = {
    tmux = { };
  };
}
