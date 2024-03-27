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

zstyle ':completion:*' completer _extensions _complete _approximate _cd _tilde

zstyle ':completion:*' menu select interactive
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:parameters' extra-verbose yes
zstyle ':completion:*' complete-options yes
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'r:|[.]=**' 'l:|=* r:|=*' # partial sub-string matching (not fuzzy matching)
zstyle ':completion:*:descriptions'      format $'%B%{\e[03;92m%}--- %U%d%u ---%b%{\e[23m%}'
zstyle ':completion:*:*:*:*:corrections' format $'%{\e[03;33m%}--- %d (err: %e) ---%{\e[23m%}'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

zstyle ':completion:*:options' matcher 'b:-=+'

zstyle ':completion:*' prefix-needed yes
zstyle ':completion:*:functions'  ignored-patterns '*.*' '*:*' '+*'
zstyle ':completion:*:users'      ignored-patterns '_*'
zstyle ':completion:*:widgets'    ignored-patterns '*.*' '*:*'
zstyle ':completion:*' single-ignored ''

zstyle ':completion:*:-tilde-:*' tag-order directory-stack named-directories

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*' users

zstyle ':completion:*:default' select-prompt '%F{black}%K{12}line %l %p%f%k'

zstyle ':completion:*:*:make:*' tag-order 'targets'

# hide all remote git branches and unhelpful completions
zstyle ':completion:*:*:git:*' ignored-patterns checkout-index check-attr check-ignore check-mailmap check-ref-format cherry
zstyle ':completion::complete:git-*:*:headrefs'                      command "echo"
zstyle ':completion::complete:git-*:*:reflog-entries'                command "echo"
zstyle ':completion::complete:git-*:*:*-tag-refs'                    command "echo"
zstyle ':completion::complete:git-*:*:tagrefs'                       command "echo"
zstyle ':completion::complete:git-*:*:commits'                       command "echo"
zstyle ':completion::complete:git-*:*:commits'                       hidden  all
zstyle ':completion::complete:git-*:*:heads-local'                   hidden  all
zstyle ':completion::complete:git-*:*:remote-branch-*'               command "echo"
zstyle ':completion::complete:git-checkout:*:changed-in-working-tree-files' command "echo"
zstyle ':completion::complete:git-*:*:tree-ishs:*'                   command "echo"
zstyle ':completion::complete:git-checkout:*' tag-order 'tree-ishs modified-files'
zstyle ':completion::complete:git-diff:*' tag-order changed-in-working-tree-files

# smarter auto-complete for ssh, aka read .ssh/config, and ignore meaningless IPs
zstyle ':completion:*:ssh:*' hosts
zstyle ':completion:*:(ssh|scp|rsync):*' ignored-patterns loopback ip6-loopback localhost ip6-localhost broadcasthost '\!*' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# be smart about case
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

# `man zshmodules` - Search “Colored completion listings”
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# zstyle ':completion:*:*:<scriptname>*:*' file-patterns '*.tsv'

fpath+=/opt/homebrew/share/zsh-completions      # zsh-completions package installed via pkg manager
fpath+=/opt/homebrew/share/zsh/site-functions   # zsh completions installed by individual homebrew packages

setopt ALWAYS_TO_END        # when completing from the middle of a word, move the cursor to the end of the word
setopt AUTO_LIST
setopt AUTO_MENU            # use either this OR MENU_COMPLETE, see: https://linux.die.net/man/1/zshoptions
setopt CASE_GLOB
setopt CASE_MATCH
setopt COMPLETE_ALIASES     # complete alisases
setopt COMPLETE_IN_WORD     # allow completion from within a word/phrase
setopt GLOB_COMPLETE
setopt LIST_AMBIGUOUS       # complete as much of a completion until it gets ambiguous.
setopt LIST_PACKED

if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit -u;
else
    compinit -C;
fi;

source <(kubectl completion zsh)
