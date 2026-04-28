#!/usr/bin/env zsh

setopt multios
setopt cdable_vars
setopt auto_remove_slash
setopt extended_glob

autoload zsh/terminfo
autoload -Uz colors
colors

# Kitty sets $TERMINFO to its own bundled terminfo (single directory, exclusive).
# Override with TERMINFO_DIRS so ~/.terminfo is searched first, allowing local
# patches (e.g. corrected Smulx for tmux-256color) to take precedence.
if [[ -n "$TERMINFO" ]]; then
  export TERMINFO_DIRS="${HOME}/.terminfo:${TERMINFO}"
  unset TERMINFO
fi
