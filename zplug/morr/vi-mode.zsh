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

#vim_mode="[i]"
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
