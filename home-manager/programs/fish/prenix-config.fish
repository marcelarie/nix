# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions -q __zoxide_cd_internal
    if builtin functions -q cd
        builtin functions -c cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

set __zoxide_z_prefix 'z#'

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (count $argv)
    set -l completion_regex '^'(string escape --style=regex $__zoxide_z_prefix)'(.*)$'

    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if set -l result (string match --groups-only --regex $completion_regex $argv[-1])
        __zoxide_cd $result
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions for `z`.
function __zoxide_z_complete
    set -l tokens (commandline --current-process --tokenize)
    set -l curr_tokens (commandline --cut-at-cursor --current-process --tokenize)

    if test (count $tokens) -le 2 -a (count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        __fish_complete_directories "$tokens[2]" ''
    else if test (count $tokens) -eq (count $curr_tokens)
        # If the last argument is empty, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (zoxide query --exclude (__zoxide_pwd) -i -- $query)
        and echo $__zoxide_z_prefix$result
        commandline --function repaint
    end
end

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query -i -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

abbr --erase z &>/dev/null
complete -c z -e
function z
    __zoxide_z $argv
end
complete -c z -f -a '(__zoxide_z_complete)'

abbr --erase zi &>/dev/null
complete -c zi -e
function zi
    __zoxide_zi $argv
end

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.config/fish/config.fish):
#
# zoxide init fish | source

# base16-gruvbox-dark-medium # :)

### "bat" as manpager
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANPAGER='nvim +Man!'

# ≃≃≃≃≃≃≃≃≃≃≃≃≃≃ #
#  KEY-BINDINGS  #
# ≃≃≃≃≃≃≃≃≃≃≃≃≃≃ ⩨

bind -M insert \ce end-of-line # on vi-mode

# ≃≃≃≃≃≃≃≃≃≃≃≃≃≃ #
#    STARTUP     #
# ≃≃≃≃≃≃≃≃≃≃≃≃≃≃ ⩨

# xset r rate 150 45
set fish_greeting
# ~/clones/forks/fetch-master-6000/fm6000.pl

# /home/marcel/clones/own/git-tellme/target/release/git-tellme
# fm6000

fish_vi_key_bindings

source /opt/homebrew/opt/asdf/libexec/asdf.fish

for p in /run/current-system/sw/bin
    if not contains $p $fish_user_paths
        set -g fish_user_paths $p $fish_user_paths
    end
end

# status --is-interactive; and rbenv init - fish | source

set -g fish_user_paths /Users/marcelmanzanares2/scripts $fish_user_paths
status --is-interactive; and rbenv init - fish | source


# Generated for envman. Do not edit.
# test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"
starship init fish | source

# Atuin config
set -gx ATUIN_NOBIND "true"
status --is-interactive; atuin init fish | source
bind --erase \cr
bind -M insert \cr _atuin_search
# end

fnm env --use-on-cd | source
