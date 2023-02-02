{ pkgs
, config
, lib
, ...
}:
with lib; {
  config. programs.starship = {
    enable = true;
    settings = {
      command_timeout = 1000;
    };
  };
}
