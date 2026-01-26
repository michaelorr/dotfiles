# For information on the completion plugin for zstyle:
# `man zshcompsys` - Search for "Standard Styles"
# `man zshmodules` - Search for “zstyle”
#
# zstyle ':completion:<function>:<completer>:<command>:<argument>:<tag>' <style> <value>
#
# completion - String acting as a namespace, to avoid pattern collisions with other scripts also using zstyle.
# <function> - Apply the style to the completion of an external function or widget.
# <completer> - Apply the style to a specific completer. We need to drop the underscore from the completer’s name here.
# <command> - Apply the style to a specific command, like cd, rm, or sed for example.
# <argument> - Apply the style to the nth option or the nth argument. It’s not available for many styles.
# <tag> - Apply the style to a specific tag. A type of match. For example “files”, “domains”, “users”, or “options” are tags.
#
# Information on Tags: `man zshcompsys` - Search for "Standard Tags"
#
# `Ctrl-x h` to see help info from completion system
#
# Formatting:
# - `%F{<color>} foo %f` - Change the foreground color of `foo` with <color>.
# - `%K{<color>} foo %k` - Change the background color of `foo` with <color>.
# - `%B foo %b` - Bold `foo`.
# - `%U foo %u` - Underline `foo`.

autoload -Uz compinit

zstyle ':completion:*' completer _extensions _complete _cd _tilde

zstyle ':completion:*' menu select interactive
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' complete-options yes
zstyle ':completion:*' prefix-needed yes
zstyle ':completion:*' single-ignored ''
zstyle ':completion:*' users
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # partial sub-string matching (not fuzzy matching)
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' accept-exact '*(N)'

# `man zshmodules` - Search “Colored completion listings”
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*:-tilde-:*'     tag-order        directory-stack    named-directories
zstyle ':completion:*:default'       select-prompt    '%F{black}%K{12}line %l %p%f%k'
zstyle ':completion:*:descriptions'  format           $'%B%{\e[03;92m%}--- %U%d%u ---%b%{\e[23m%}'
zstyle ':completion:*:functions'     ignored-patterns '*.*' '*:*' '+*'
zstyle ':completion:*:options'       matcher          'b:-=+'
zstyle ':completion:*:parameters'    extra-verbose    yes
zstyle ':completion:*:processes'     command          'ps -au$USER'
zstyle ':completion:*:users'         ignored-patterns '_*'
zstyle ':completion:*:warnings'      format           '%F{red}-- no matches found --%f'
zstyle ':completion:*:widgets'       ignored-patterns '*.*' '*:*'

# smarter auto-complete for ssh, aka read .ssh/config, and ignore meaningless IPs
zstyle ':completion:*:ssh:*' hosts
zstyle ':completion:*:(ssh|scp|rsync):*' ignored-patterns loopback ip6-loopback localhost ip6-localhost broadcasthost '\!*' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:make:*' tag-order 'targets'

# hide all remote git branches and unhelpful completions
zstyle ':completion:*:*:git:*' ignored-patterns checkout-index check-attr check-ignore check-mailmap check-ref-format cherry
zstyle ':completion::complete:git-*:*:headrefs'                             command     "echo"
zstyle ':completion::complete:git-*:*:reflog-entries'                       command     "echo"
zstyle ':completion::complete:git-*:*:*-tag-refs'                           command     "echo"
zstyle ':completion::complete:git-*:*:tagrefs'                              command     "echo"
zstyle ':completion::complete:git-*:*:commits'                              command     "echo"
zstyle ':completion::complete:git-*:*:commits'                              hidden      all
zstyle ':completion::complete:git-*:*:heads-local'                          hidden      all
zstyle ':completion::complete:git-*:*:remote-branch-*'                      command     "echo"
zstyle ':completion::complete:git-*:*:tree-ishs:*'                          command     "echo"
zstyle ':completion::complete:git-checkout:*'                               tag-order   'tree-ishs modified-files'
zstyle ':completion::complete:git-diff:*'                                   tag-order   changed-in-working-tree-files
zstyle ':completion::complete:git-checkout:*:changed-in-working-tree-files' command     "echo"

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':completion:*' menu no

fpath+=/opt/homebrew/share/zsh-completions      # zsh-completions package installed via pkg manager
fpath+=/opt/homebrew/share/zsh/site-functions   # zsh completions installed by individual homebrew packages

setopt ALWAYS_TO_END        # when completing from the middle of a word, move the cursor to the end of the word
setopt AUTO_PARAM_SLASH
setopt CASE_GLOB
setopt CASE_MATCH
setopt COMPLETE_ALIASES     # complete alisases
setopt COMPLETE_IN_WORD     # allow completion from within a word/phrase
setopt GLOB_COMPLETE
setopt HASH_LIST_ALL
setopt LIST_AMBIGUOUS       # complete as much of a completion until it gets ambiguous.
setopt LIST_PACKED
# It may be tempting to enable AUTO_MENU and disable this based on the description in the docs
# Don't do it. The behavior is weird and you get innacurate results
setopt MENU_COMPLETE

local -a old_zcompdump=(~/.zcompdump(N.mh+24))
if [[ ! -f ~/.zcompdump ]] || (( ${#old_zcompdump} )); then
  rm -f ~/.zcompdump
  compinit
else
  compinit -C
fi

zsh-defer source $DOT/zsh/fzf-tab/fzf-tab.plugin.zsh

local kubectl_completion=~/.zsh_kubectl_completion
local -a old_kubectl_completion=($kubectl_completion(N.mh+24))
if [[ ! -f $kubectl_completion ]] || (( ${#old_kubectl_completion} )); then
  kubectl completion zsh > $kubectl_completion
fi
zsh-defer source $kubectl_completion
