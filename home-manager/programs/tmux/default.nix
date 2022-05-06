{
  pkgs,
  config,
  ...
}: {
  config.programs.tmux = {
    enable = true;
  };
}
