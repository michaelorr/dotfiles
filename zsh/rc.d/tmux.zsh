#!/usr/bin/env zsh

[[ -n "$ZSH_TMUX_AUTOSTART" ]] || ZSH_TMUX_AUTOSTART=false
[[ -n "$ZSH_TMUX_AUTOCONNECT" ]] || ZSH_TMUX_AUTOCONNECT=true
[[ -n "$ZSH_TMUX_AUTOQUIT" ]] || ZSH_TMUX_AUTOQUIT=$ZSH_TMUX_AUTOSTART

function _tmux_wrapper() {
  if [[ -n "$@" ]]; then
    \tmux $@
  elif [[ "$ZSH_TMUX_AUTOCONNECT" == "true" ]]; then
    unattached_sessions=$(tmux list-sessions -f '#{==:#{session_attached},0}' -F '#{session_name}' 2>/dev/null | grep -v -E '^scratch$|^scratch2$|^lazygit$|^claude_')
    if [[ -z "$unattached_sessions" ]]; then
      \tmux new-session
    else
      first_unattached_session=$(echo "$unattached_sessions" | head -n1)
      \tmux attach -t "$first_unattached_session" || \tmux new-session
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
