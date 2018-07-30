#!/usr/bin/env zsh

# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#History-Control
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html
#
# To determine key codes, press ctrl-v and press desired key

# [shift-tab]: should cycle backwards in completions with vi-mode on
bindkey -M viins "^[[Z" reverse-menu-complete

# [up] / [down]: prefix search backward/foward in history, keep cursor in place
bindkey -M viins "^[[A" history-beginning-search-backward
bindkey -M viins "^[[B" history-beginning-search-forward

# [shift+left] / [shift+right]: jump to beginning / end of line
bindkey "^[[1;2D" beginning-of-line
bindkey "^[[1;2C" end-of-line

# [Backspace] - delete backward
bindkey '^?' vi-backward-delete-char
if [[ "${terminfo[kdch1]}" != "" ]]; then
  # [Delete] - delete forward
  bindkey "${terminfo[kdch1]}" vi-delete-char
else
  bindkey "^[[3~" vi-delete-char
  bindkey "^[3;5~" vi-delete-char
  bindkey "\e[3~" vi-delete-char
fi
