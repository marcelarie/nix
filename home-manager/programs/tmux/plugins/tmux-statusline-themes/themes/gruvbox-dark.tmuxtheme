# Tmux status line with gruvbox dark colors.
# Palette: https://github.com/morhetz/gruvbox#palette

# Status bar colors.
set-option -g status-fg colour223 # fg1
set-option -g status-bg colour235 # bg0

# Window list colors.
set-window-option -g window-status-style fg=colour246,bg=colour239
set-window-option -g window-status-current-style fg=colour235,bg=colour246,bright
set-window-option -g window-status-activity-style fg=colour250,bg=colour241

# Pane divider colors.
set-option -g pane-border-style fg=colour239 # bg2
set-option -g pane-border-style bg=colour235 # bg0
set-option -g pane-active-border-style fg=colour142 # brightgreen
set-option -g pane-active-border-style bg=colour235 # bg0

# Command-line messages colors.
set-option -g message-style fg=colour223 # fg1
set-option -g message-style bg=colour235 # bg0
set-option -g message-style bright

# Set left and right sections.
set-option -g status-left-length 20
set-option -g status-left "#[fg=colour235,bg=colour246] #S "
set-option -g status-right "#[fg=colour235,bg=colour246] #(whoami)@#H "

# Set format of items in window list.
setw -g window-status-format " #I:#W#F "
setw -g window-status-current-format " #I:#W#F "

# Set alignment of windows list.
set-option -g status-justify centre

# Identify activity in non-current windows.
set-window-option -g monitor-activity on
set-option -g visual-activity on
