#!/usr/bin/env bash
# Manages switching between named tmux popups.
# Closes any currently open managed popup before opening the requested one.
#
# Usage (from tmux.conf):
#   run-shell "popup.sh TARGET '#{session_name}' '#{client_name}' '#{popup_pane_id}' '#{pane_current_path}'"
#
# Targets: scratch | scratch2 | claude | lazygit

target="$1"
current="$2"
client="$3"
parent_pane="$4"
current_path="${5:-$HOME}"

open_popup() {
  local args=()
  [[ -n "$1" ]] && args+=(-t "$1")
  case "$target" in
  scratch)
    tmux display-popup "${args[@]}" -d "$current_path" -xC -yC -w85% -h80% -E "tmux new-session -A -s scratch"
    ;;
  scratch2)
    tmux display-popup "${args[@]}" -d "$current_path"-xC -yC -w85% -h80% -E "tmux new-session -A -s scratch2"
    ;;
  claude)
    tmux display-popup "${args[@]}" -d "$current_path" -xC -yC -w85% -h80% -E "$DOT/tmux/claude_session.sh $current_path"
    ;;
  lazygit)
    tmux display-popup "${args[@]}" -d "$current_path" -w 85% -h 80% -E "lazygit"
    ;;
  esac
}

is_current_target() {
  case "$target" in
  scratch) [[ "$current" == "scratch" ]] ;;
  scratch2) [[ "$current" == "scratch2" ]] ;;
  claude) [[ "$current" == claude_* ]] ;;
  *) return 1 ;;
  esac
}

if is_current_target; then
  tmux detach-client -t "$client"
else
  open_popup "$parent_pane"
fi
