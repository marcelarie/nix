{ pkgs, spacebar, ... }:
let spacebar_height = 25;
in {
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    package = pkgs.yabai.overrideAttrs (old: rec {
      version = "4.0.0";
      src = pkgs.fetchFromGitHub {
        owner = "koekeishiya";
        repo = "yabai";
        rev = "41414989666232f4344329e250f38db2f0a1cc48";
        sha256 = "sha256-xpp1WKUCF/+MWBRdV/QLL7GpdE0lsN4rAPjqLhDL41U=";
      };
    });
    config = {
      auto_balance = "on";
      layout = "bsp";
      bottom_padding = 48;
      left_padding = 18;
      right_padding = 18;
      top_padding = 18;
      window_gap = 18;
      mouse_follows_focus = "on";
      mouse_modifier = "fn";
      split_ratio = "0.50";
      window_placement = "second_child";
      window_topmost = "off";
      window_opacity = "off";
      window_shadow = "on";
      window_border = "off";
    };
  };
  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      position = "top";
      height = spacebar_height;
      title = "on";
      spaces = "on";
      power = "on";
      clock = "on";
      right_shell = "off";
      padding_left = 20;
      padding_right = 20;
      spacing_left = 25;
      spacing_right = 25;
      text_font = ''"FiraCode Nerd Font:16.0"'';
      icon_font = ''
        "Font Awesome 5 Free:Solid:12.0, Font Awesome 5 Brands:Courant:12.0"'';
      background_color = "0xff202020";
      foreground_color = "0xffD8DEE9";
      space_icon_color = "0xff8fBcBB";
      power_icon_strip = " ";
      space_icon_strip = "I II III IV V VI VII VIII IX X";
      display = "all";
      spaces_for_all_displays = "on";
      display_separator = "on";
      display_separator_icon = "|";
      clock_format = ''"%d/%m/%y %R"'';
      right_shell_icon = " ";
      right_shell_command = "whoami";
    };
  };
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      # focus window
      # here the || was added so the selection cycles and doesn't stop at the end or beginning
      alt - j : yabai -m window --focus prev || yabai -m window --focus last
      alt - k : yabai -m window --focus next || yabai -m window --focus first

      # open alacritty
      # alt - return : /Applications/Alacritty.app/Contents/MacOS/alacritty -e '/etc/profiles/per-user/marcelmanzanares2/bin/fish'

      # open alacritty
      alt - return : /etc/profiles/per-user/marcelmanzanares2/bin/kitty --single-instance '/etc/profiles/per-user/marcelmanzanares2/bin/fish'

      # close window
      shift + alt - q : skhd --key "cmd - w"
      alt - q : open -a Google\ Chrome -n

      # todo check this
      # in leftwm Meta + h changes focus to the other screen
      # in leftwm Meta + j changes focus to the other screen
      alt - h : yabai -m display --focus west
      alt - l : yabai -m display --focus east

      shift + alt - w : yabai -m window --display next; yabai -m display --focus next || yabai -m window --display prev; yabai -m display --focus prev
      alt - w : yabai -m space --display next || yabai -m space --display prev

      # swap window
      # alt - return : yabai -m window --swap west # swap with "main" tile (simply swap it west)
      shift + alt - j : yabai -m window --swap prev
      shift + alt - k : yabai -m window --swap next

      # move window
      shift + cmd - h : yabai -m window --warp west || $(yabai -m window --display west; yabai -m display --focus west)
      shift + cmd - j : yabai -m window --warp north
      shift + cmd - k : yabai -m window --warp next
      shift + cmd - l : yabai -m window --warp east || $(yabai -m window --display east; yabai -m display --focus east)

      # balance size of windows
      shift + alt - 0 : yabai -m space --balance

      # fast focus desktop
      alt - 1 : yabai -m space --focus 1
      alt - 2 : yabai -m space --focus 2
      alt - 3 : yabai -m space --focus 3
      alt - 4 : yabai -m space --focus 4
      alt - 5 : yabai -m space --focus 5
      alt - 6 : yabai -m space --focus 6
      alt - 7 : yabai -m space --focus 7
      alt - 8 : yabai -m space --focus 8
      alt - 9 : yabai -m space --focus 9
      alt - 0 : yabai -m space --focus 10

      # send window to desktop and follow focus
      shift + alt - 1 : yabai -m window --space  1
      shift + alt - 2 : yabai -m window --space  2
      shift + alt - 3 : yabai -m window --space  3
      shift + alt - 4 : yabai -m window --space  4
      shift + alt - 5 : yabai -m window --space  5
      shift + alt - 6 : yabai -m window --space  6
      shift + alt - 7 : yabai -m window --space  7
      shift + alt - 8 : yabai -m window --space  8
      shift + alt - 9 : yabai -m window --space  9
      shift + alt - 0 : yabai -m window --space 10

      # increase window size (this is the hack that gives xmonad like resizing)
      shift + alt - h : expr $(yabai -m query --windows --window | jq .frame.x) \< 20 && yabai -m window --resize right:-60:0 || yabai -m window --resize left:-60:0
      shift + alt - l : expr $(yabai -m query --windows --window | jq .frame.x) \< 20 && yabai -m window --resize right:60:0 || yabai -m window --resize left:60:0
      shift + alt - i : yabai -m window --resize bottom:0:-60
      shift + alt - o : yabai -m window --resize bottom:0:60

      # rotate tree
      alt - r : yabai -m space --rotate 90

      # mirror tree y-axis
      alt - y : yabai -m space --mirror y-axis

      # mirror tree x-axis
      alt - x : yabai -m space --mirror x-axis

      # toggle window fullscreen zoom
      alt - f : yabai -m window --toggle zoom-fullscreen

      # toggle window native fullscreen
      # alt - space : yabai -m window --toggle native-fullscreen
      # shift + alt - f : yabai -m window --toggle native-fullscreen

      # toggle window border
      shift + alt - b : yabai -m window --toggle border

      # toggle window split type
      alt - e : yabai -m window --toggle split

      # float / unfloat window and center on screen
      alt - t : yabai -m window --toggle float;\
                yabai -m window --grid 4:4:1:1:2:2

      # toggle sticky
      # alt - s : yabai -m window --toggle sticky

      # toggle sticky, float and resize to picture-in-picture size
      # alt - p : yabai -m window --toggle sticky;\
      #           yabai -m window --grid 5:5:4:0:1:1

      alt + shift - r : \
          launchctl kickstart -k "gui/$\{UID}/homebrew.mxcl.yabai"; \
          skhd --reload

      # change layout of desktop
      ctrl + alt - b : yabai -m space --layout bsp
      ctrl + alt - f : yabai -m space --layout float
    '';
  };
}
