setopt prompt_subst
setopt interactivecomments

source "${0:a:h}/functions.zsh"
local reset=$'%{\033[0m%}'

# >>>
# >>> zsh-users/zsh-syntax-highlighting
# >>>
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
export ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red' 2>/dev/null
export ZSH_HIGHLIGHT_STYLES[comment]='fg=14' 2>/dev/null # pale blue

# >>>
# >>> zsh-users/zsh-autosuggestions
# >>>
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239' # dark gray
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# >>>
# >>> LS
# >>>
# always show colors and file suffixes
export CLICOLOR=1
alias ls='ls -F'
# See `man ls` on linux for guide to LS_COLORS
# Use theme colors when autocompleting files/folders
export LS_COLORS='no=0:di=34:ln=32:or=32:mi=31:ex=35:st=34:ow=34:tw=34'
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
# See `man ls` on osx for guide to LSCOLORS
# LSCOLORS="excxdxdxfxdxdxfxfxexex"
export LSCOLORS="excxdxdxfxdxdxfxfxexex"

# >>>
# >>> Prompt
# >>>
local zsh_prompt_prefix="->>"
local zsh_prompt_divider="%{$FG[005]%}❯"

ZSH_THEME_GIT_PROMPT_DIRTY="%{${FG[003]}%}%{${FX[italic]}%}" # italic yellow
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[004]%}" # blue
zsh_prompt_response_code="%{%(?.$FG[002].$FG[001])%}$zsh_prompt_prefix" # (?.$GREEN.$RED)

PS1='${zsh_prompt_response_code}%{$FG[004]%}$(_zsh_theme::prompt::dir)$(_zsh_theme::prompt::git)$reset '
