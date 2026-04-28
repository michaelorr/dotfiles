${TPL_HEADER}
# zsh
set -g default-shell $SHELL

## mac's tmux->clipboard->vim hurdle jumping
set -g set-clipboard on
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"

## prefix setup
unbind C-b
set -g prefix C-a
bind C-a run 'true'
bind a send-prefix

set -g base-index 1

## Don't delay in sending ESC to the subshell. Without this vim is frustrating.
set -sg escape-time 0

# Increase tmux messages display duration from 750ms to 2s
set -g display-time 2000

set -g history-limit 50000

set -g default-terminal "tmux-256color"
set -as terminal-overrides ',xterm-kitty:RGB'

set -wg aggressive-resize on

bind | split-window -h
bind - split-window -v

bind N new

# easier keybinds
# allows to hold Ctrl and repeat a+p / a+n
bind C-p previous-window
bind C-n next-window

## Vim style pane selection
set -wg mode-keys vi
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

## Reload tmux config
bind r source-file ~/.tmux.conf

## ^ay will toggle pane sync (send typing to all windows or not)
bind y set-window-option synchronize-panes

# moves current pane to a new window
bind ! break-pane

set -g mouse on

## Status bar
set -g status on
set -g status-position bottom
set -g status-keys vi
set -g status-interval 60

## Colors
set -g visual-activity on

run ${DOT}/colors/gruvbox_tmux/src/gruvbox-main.sh
set -g @tmux-gruvbox 'dark'

set -g window-style "bg=#282828"
set -g window-active-style "bg=#181818"

set -g pane-border-style "bg=#282828,#{?pane_synchronized,fg=color13,fg=color239}"
set -g pane-active-border-style "bg=#282828,#{?pane_synchronized,fg=color13,fg=color239}"

set -g pane-border-indicators off
set -g pane-border-lines "heavy"

set -g status-left "#{?client_prefix,#[fg=color237 bg=color6 italics],#[fg=color223,bg=color237]} #S "
set -g status-right "#[fg=white]#(tmux_kubectx.sh) │ %H:%M │ #(TZ=UTC date -u +%%H:%%M) UTC #(tmux_battery.sh)"
set -g mode-style "fg=#dfdfe5,bg=color4"
set -g display-panes-active-color color3
set -g display-panes-color color250
set -wg pane-border-status off
set -wg pane-border-format ""
set -wg window-status-separator ""
set -wg popup-border-lines rounded

set -g window-status-current-format "#[bg=color237,fg=color4,nobold,italics]|#[bold]#I#[nobold]:#W#{?#{||:#{window_marked_flag},#{window_zoomed_flag}},(,}#{?window_marked_flag,m,}#{?window_zoomed_flag,z,}#{?#{||:#{window_marked_flag},#{window_zoomed_flag}},),}|"
set -g window-status-format         "#[bg=color237,fg=white,bold]#{?#{e|==:#{e|-:#I,1},#{active_window_index}},, }#I#[nobold]:#[bg=color237,fg=white]#W#{?#{||:#{window_marked_flag},#{window_zoomed_flag}},(,}#{?window_marked_flag,m,}#{?window_zoomed_flag,z,}#{?#{||:#{window_marked_flag},#{window_zoomed_flag}},),}#[bg=color237,fg=white,noitalics]"

bind o if-shell -F "#{==:#{session_name},scratch}" {
detach-client
} {
display-popup \
  -xC -yC -w85% -h80% \
  -E "tmux new-session -A -s scratch"
}

bind O if-shell -F "#{==:#{session_name},scratch2}" {
detach-client
} {
display-popup \
  -xC -yC -w85% -h80% \
  -E "tmux new-session -A -s scratch2"
}

bind v if-shell -F "#{m:claude_*,#{session_name}}" {
detach-client
} {
display-popup \
  -d "#{pane_current_path}" \
  -xC -yC -w85% -h80% \
  -E "${DOT}/tmux/claude_session.sh #{pane_current_path}"
}

bind g display-popup \
  -d "#{pane_current_path}" \
  -w 85% -h 80% \
  -E "lazygit"

bind-key J join-pane
bind-key j command-prompt -p "join pane from:"  "join-pane -s '%%'"

set -g focus-events on
set -g renumber-windows on

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'sainnhe/tmux-fzf'
run '~/.tmux/plugins/tpm/tpm'

# vim: ft=tmux:syntax=tmux
