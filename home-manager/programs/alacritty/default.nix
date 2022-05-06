{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        opacity = 1;
        dynamic_title = true;
        dynamic_padding = false;
        startup_mode = "Windowed";
        # decorations = "full";
        dimensions = {
          columns = 100;
          lines = 85;
        };
        padding = {
          x = 0;
          y = 0;
        };
      };

      scrolling = {
        history = 100000;
        multiplier = 3;
      };

      mouse = {hide_when_typing = true;};

      key_bindings = [
        {
          # clear terminal
          key = "L";
          mods = "Control";
          chars = "\\x0c";
        }
      ];

      font = let
        # fontname = "SauceCodePro Nerd Font Mono";
        fontname = "FiraCode Nerd Font";
      in {
        #font = let fontname = "Recursive Mono Linear Static"; in { # TODO fix this font with nerd font
        normal = {
          family = fontname;
          # style = "Semibold";
        };
        bold = {
          family = fontname;
          style = "Medium";
        };
        italic = {
          family = fontname;
          # style = "Semibold Italic";
          style = "Light Italic";
        };
        size = 13;
        glyph_offset = {
          x = 0;
          y = 0;
        };
        offset = {
          x = 0;
          y = 0;
        };
        use_thin_strokes = true;
      };
      cursor.style = "Block";
      draw_bold_text_with_bright_colors = false;

      colors = import ./colors/lighthaus.nix;
      bell = {
        animation = "EaseOutExpo";
        color = "0xffffff";
        duration = 0;
      };
    };
  };
}
