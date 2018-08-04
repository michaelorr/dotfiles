#!/usr/bin/env zsh

# To determine key codes for a desired key press, use ctrl-v and press desired key
# To see current keymaps:
# keybind -M viins
# keybind -M vicmd

# [shift-tab]: should cycle backwards in completions with vi-mode on
bindkey -M viins "^[[Z" reverse-menu-complete

# [up] / [down]: prefix search backward/foward in history, keep cursor in place
bindkey -M viins "^[[A" history-beginning-search-backward
bindkey -M viins "^[[B" history-beginning-search-forward

# [shift+left] / [shift+right]: jump to beginning / end of line
bindkey -M viins "^[[1;2D" beginning-of-line
bindkey -M viins "^[[1;2C" end-of-line
bindkey -M vicmd "^[[1;2D" beginning-of-line
bindkey -M vicmd "^[[1;2C" end-of-line

# [Backspace] - delete backward past insert mode marker
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char

# [Delete] - delete forward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey -M viins "${terminfo[kdch1]}" vi-delete-char
  bindkey -M vicmd "${terminfo[kdch1]}" vi-delete-char
else
  bindkey -M viins "^[[3~" vi-delete-char
  bindkey -M viins "^[3;5~" vi-delete-char
  bindkey -M viins "\e[3~" vi-delete-char
  bindkey -M vicmd "^[[3~" vi-delete-char
  bindkey -M vicmd "^[3;5~" vi-delete-char
  bindkey -M vicmd "\e[3~" vi-delete-char
fi

# TODO: make a better history behavior when it comes to end of line/middle of line:
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#User_002dDefined-Widgets
#
# Scenarios:
#
# Current history item: none
# Buffer: empty
# Cursor: Beginning
# Behavior:
#  - Up: move backward in history, move cursor to end
#
# Current history item: none
# Buffer: Not empty
# Cursor: Middle / end
# Behavior:
#  - Up: move backward in history with prefix search, keep cursor in place
#
# Current history item: not none
# Buffer: Not empty
# Cursor: Middle
# Behavior:
#  - Up: move backward in history with prefix search, keep cursor in place
#  - Down: move forward in history with prefix search, keep cursor in place
#
# Current history item: not none
# Buffer: Not empty
# Cursor: Beginning
# Behavior:
#  - Up: move backward in history, move cursor to end
#  - Down: move forward in history, move cursor to end
#
# Current history item: not none
# Buffer: Not empty
# Cursor: Middle
# Behavior:
#  IF: LASTWIDGET was an incremental search:
#    - Up: move backward in history with prefix search, keep cursor in place
#    - Down: move forward in history with prefix search, keep cursor in place
#  ELSE:
#    - Up: move backward in history, move cursor to end
#    - Down: move forward in history, move cursor to end
#
# Current history item: not none
# Buffer: not empty
# Cursor: End
# Behavior:
#  IF: LASTWIDGET was an incremental search:
#    - Up: move backward in history with prefix search, keep cursor in place
#    - Down: move forward in history with prefix search, keep cursor in place
#  ELSE:
#    - Up: move backward in history, move cursor to end
#    - Down: move forward in history, move cursor to end
