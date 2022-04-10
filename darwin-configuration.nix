{ config, pkgs, ... }:

# Use a custom configuration.nix location.
# $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
# environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

{
  imports = [
    <home-manager/nix-darwin>
  ];
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };
  services.nix-daemon.enable = true;

  nix.registry."node".to = {
    type = "github";
    owner = "andyrichardson";
    repo = "nix-node";
  };

  nix.binaryCaches = [ "https://cache.nixos.org/" "https://nix-node.cachix.org/" ];

  environment.systemPackages = with pkgs;
    [
      gcc
      cmake
      bind
    ];

  # fonts.fonts = with pkgs; [
  #   noto-fonts
  #   noto-fonts-cjk
  #   noto-fonts-emoji
  #   liberation_ttf
  #   fira-code
  #   fira-code-symbols
  #   nerdfonts
  # ];

  environment.variables = {
    SYS_THEME = "dark";
    VI_CONFIG = "~/.config/nvim/init.vim";
  };

  # services.spacebar = {
  #   enable = false;
  #   package = pkgs.spacebar;
  #   config = {
  #     position = "top";
  #     display = "main";
  #     height = 26;
  #     title = "on";
  #     spaces = "on";
  #     clock = "on";
  #     power = "on";
  #     padding_left = 20;
  #     padding_right = 20;
  #     spacing_left = 25;
  #     spacing_right = 15;
  #     text_font = ''"Menlo:Regular:12.0"'';
  #     icon_font = ''"Font Awesome 5 Free:Solid:12.0"'';
  #     background_color = "0xff202020";
  #     foreground_color = "0xffa8a8a8";
  #     power_icon_color = "0xffcd950c";
  #     battery_icon_color = "0xffd75f5f";
  #     dnd_icon_color = "0xffa8a8a8";
  #     clock_icon_color = "0xffa8a8a8";
  #     power_icon_strip = "Ôàû ÔÉß";
  #     space_icon = "‚Ä¢";
  #     space_icon_strip = "1 2 3 4 5 6 7 8 9 10";
  #     spaces_for_all_displays = "on";
  #     display_separator = "on";
  #     display_separator_icon = "ÔÑÖ";
  #     space_icon_color = "0xff458588";
  #     space_icon_color_secondary = "0xff78c4d4";
  #     space_icon_color_tertiary = "0xfffff9b0";
  #     clock_icon = "ÔÄó";
  #     dnd_icon = "ÔÜÜ";
  #     clock_format = ''"%d/%m/%y %R"'';
  #     right_shell = "on";
  #     right_shell_icon = "ÔÑ†";
  #     right_shell_command = "whoami";
  #   };
  # };

  # services.yabai = {
  #   enable = false;
  #   package = pkgs.yabai;
  #   enableScriptingAddition = true;
  #   config = {
  #     focus_follows_mouse = "autoraise";
  #     mouse_follows_focus = "off";
  #     window_placement = "second_child";
  #     window_opacity = "off";
  #     window_opacity_duration = "0.0";
  #     window_topmost = "on";
  #     window_shadow = "float";
  #     active_window_opacity = "1.0";
  #     normal_window_opacity = "1.0";
  #     split_ratio = "0.50";
  #     auto_balance = "on";
  #     mouse_modifier = "fn";
  #     mouse_action1 = "move";
  #     mouse_action2 = "resize";
  #     layout = "bsp";
  #     top_padding = 36;
  #     bottom_padding = 10;
  #     left_padding = 10;
  #     right_padding = 10;
  #     window_gap = 10;
  #   };
  #
  #   extraConfig = ''
  #     # rules
  #     yabai -m rule --add app='System Preferences' manage=off
  #
  #     # Any other arbitrary config here
  #   '';
  # };

  home-manager = {
    useUserPackages = true;
    users."m.manzanares" = {
      nixpkgs.overlays = pkgs.overlays;
      imports = [ ./home-manager/home.nix ];
    };
  };

  # programs.zsh.enable = true; # default shell on catalina
  programs.fish.enable = true;

  system.stateVersion = 4;
}
