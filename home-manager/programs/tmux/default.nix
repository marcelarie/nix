{ pkgs
, config
, ...
}: {
  config.programs.tmux = {
    aggressiveResize = true;
    baseIndex = 1;
    enable = true;
    terminal = "screen-256color";
    clock24 = true;
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";
    shortcut = "Space";
    extraConfig = ''
      set -g status-justify "left"
      set -g status "on"
      set -g message-command-style "fg=colour154,bg=colour0"
      set -g message-style "fg=colour154,bg=colour0"
      set -g status-right-length "100"
      set -g status-left-length "100"
      setw -g window-status-separator ""
      set -g mouse on
      bind v split-window -h -c '#{pane_current_path}'
      bind s split-window -v -c '#{pane_current_path}'
      bind c new-window -c '#{pane_current_path}'
      bind-key R source-file $HOME/.config/tmux/tmux.conf \; display-message "$HOME/.config/tmux/tmux.conf reloaded"
      bind L switch-client -l
      bind J display-popup -E "\
      tmux list-panes -a -F '#{?session_attached,,#S:#I.#P}' |\
      sed '/^$/d' |\
      fzf --reverse --header join-pane --preview 'tmux capture-pane -pt {}'  |\
      xargs tmux join-pane -v -s"
      set-option -g renumber-windows on
      set -g status-bg colour0
      set -g status-fg colour154
    '';
  };
}
