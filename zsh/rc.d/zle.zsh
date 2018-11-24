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

zle -N morr-backward-delete-word
morr-backward-delete-word () {
    # zle looks to WORDCHARS to determine what to consider a "word"
    # This local var overrides the global value. It is identical
    # except I remove the `/` because it helps with paths.
    local WORDCHARS='*?_[]~=&;!#$%^(){}<>'
    zle backward-delete-word
}

# [ctrl+\]: delete previous word
bindkey -M viins "^\\" morr-backward-delete-word
bindkey -M vicmd "^\\" morr-backward-delete-word

# [z]: in vicmd mode, edit current line in vim
autoload -U edit-command-line;
zle -N edit-command-line;
bindkey -M vicmd 'z' edit-command-line;

# [^z]: undo
bindkey -M viins "^z" undo

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
#!/usr/bin/env zsh

# VI mode
# plugins+=vi-mode
# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/vi-mode
# https://dougblack.io/words/zsh-vi-mode.html
# http://coryklein.com/vi/2015/09/17/a-working-vi-mode-indicator-in-zsh.html
# http://stratus3d.com/blog/2017/10/26/better-vi-mode-in-zshell/
# https://github.com/softmoth/zsh-vim-mode
# http://martin.krischik.com/index.php/Z-Shell/VimMode
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/vi-mode/vi-mode.plugin.zsh
# http://pawelgoscicki.com/archives/2012/09/vi-mode-indicator-in-zsh-prompt/comment-page-1/
# https://unix.stackexchange.com/questions/43003/using-vi-keys-to-edit-shell-commands-in-unix
# http://stratus3d.com/blog/2017/10/26/better-vi-mode-in-zshell/

# https://dougblack.io/words/zsh-vi-mode.html

# vim_mode="[i]"
function zle-line-init zle-keymap-select {
    #vim_mode="${${KEYMAP/vicmd/[c]}/(main|viins)/[i]}"
    case ${KEYMAP} in
      (vicmd)      VI_MODE="$(normal-mode)" ;;
      (main|viins) VI_MODE="$(insert-mode)" ;;
      (*)          VI_MODE="$(insert-mode)" ;;
    esac
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
# zle -N zle-keymap-select
# zle -N zle-line-init
#PROMPT='$vim_mode'

bindkey -v
export KEYTIMEOUT=1
