#!/usr/bin/env zsh

[[ -n "$ZSH_TMUX_AUTOSTART" ]] || ZSH_TMUX_AUTOSTART=false
[[ -n "$ZSH_TMUX_AUTOCONNECT" ]] || ZSH_TMUX_AUTOCONNECT=true
[[ -n "$ZSH_TMUX_AUTOQUIT" ]] || ZSH_TMUX_AUTOQUIT=$ZSH_TMUX_AUTOSTART

function _tmux_wrapper() {
  if [[ -n "$@" ]]; then
    \tmux $@
  elif [[ "$ZSH_TMUX_AUTOCONNECT" == "true" ]]; then
    if [[ $(tmux list-sessions -f '#{?#{==:#{session_name},scratch},0,1}' 2>/dev/null | wc -l | xargs) == "0" ]]; then
      \tmux new-session
    else
      \tmux attach || \tmux new-session
    fi
    [[ "$ZSH_TMUX_AUTOQUIT" == "true" ]] && exit
  else
    \tmux
    [[ "$ZSH_TMUX_AUTOQUIT" == "true" ]] && exit
  fi
}

compdef _tmux _tmux_wrapper
alias tmux=_tmux_wrapper

if [[ ! -n "$TMUX" && "$ZSH_TMUX_AUTOSTART" == "true" ]]; then
    if [[ "$ZSH_TMUX_AUTOSTARTED" != "true" ]]; then
        # Don't nest sessions with autostart
        export ZSH_TMUX_AUTOSTARTED=true
        _tmux_wrapper
    fi
fi
