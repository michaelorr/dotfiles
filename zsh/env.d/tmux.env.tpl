${TPL_HEADER}
# zsh/env.d/tmux.env.tpl

if [[ -o interactive ]] && [[ -n "$TERM" ]]; then
  export ZSH_TMUX_AUTOSTART=${TMUX_ENABLED}
  export ZSH_TMUX_AUTOCONNECT=${TMUX_ENABLED}
else
  export ZSH_TMUX_AUTOSTART=false
  export ZSH_TMUX_AUTOCONNECT=false
fi
export ZSH_TMUX_AUTOQUIT=$ZSH_TMUX_AUTOSTART

# vim: ft=zsh
