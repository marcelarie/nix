{ pkgs, config, lib, ... }:

with lib;
{
  config.programs.kitty =
    {
      enable = true;
      font = {
        package = pkgs.fira-code;
        name = "FiraCode";
      };
      settings = {
        font_size = "9";
        cursor_shape = "underline"; # (block, beam, underline)
        cursor_beam_thickness = "0.5";
        cursor_underline_thickness = "0.5";
        # cursor_stop_blinking_after = "15.0";
        # mouse_hide_wait = "3.0";
        focus_follows_mouse = true;
        # visual_bell_duration = "0.25";
        #hide_window_decorations = true;
        scrollback_lines = 200000;
        copy_on_select = true;
        strip_trailing_spaces = "smart";
        enable_audio_bell = false;
        window_alert_on_bell = true;
        term = "xterm-256color";
        # term =  "xterm-kitty";
        update_check_interval = 0;
        foreground = "#FFFADE";
        selection_background = "#1D918B";
        selection_foreground = "#18191E";
        background = "#000000";
        background_opacity = "1.0";
        inactive_text_alpha = "1.0";

        # Lighthouse color
        url_color = "#CCCCCC";
        cursor = "#47A8A1";

        # Tabs
        active_tab_background = "#00BFA4";
        active_tab_foreground = "#000000";
        inactive_tab_background = "#CCCCCC";
        inactive_tab_foreground = "#18191E";

        # Windows Border
        active_border_color = "#CCCCCC";
        inactive_border_color = "#CCCCCC";

        # normal
        color0 = "#373C45";
        color1 = "#FF5050";
        # color1 = "#FF0500";
        color2 = "#44B273";
        color3 = "#ED722E";
        color4 = "#1D918B";
        color5 = "#D16BB7";
        color6 = "#00BFA4";
        color7 = "#8E8D8D";

        # bright
        color8 = "#CCCCCC";
        color9 = "#FF4D00";
        color10 = "#10B981";
        color11 = "#FFFF00";
        color12 = "#0DB9D7";
        color13 = "#D68EB2";
        color14 = "#5AD1AA";
        color15 = "#FFFADE";
      };

      keybindings = {
        "kitty_mod+l" = "kitten hints --type path --program - ";
      };

      # extraConfig = "";
    };
}
