setopt prompt_subst
setopt interactivecomments

local reset=$'%{\033[0m%}'

GITSTATUS_ENABLED=true
# library for super fast `git status`
if [ -f "$DOT/git/gitstatus/gitstatus.plugin.zsh" ]; then
    source "$DOT/git/gitstatus/gitstatus.plugin.zsh"
    gitstatus_start GSD
else
    GITSTATUS_ENABLED=false
    echo "Install gitstatus [mo]"
fi

# >>>
# >>> zsh-users/zsh-syntax-highlighting
# >>>
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
typeset -gA ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
export ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
export ZSH_HIGHLIGHT_STYLES[comment]='fg=12' # pale blue

# >>>
# >>> zsh-users/zsh-autosuggestions
# >>>
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240' # dark gray
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# >>>
# >>> LS
# >>>
# always show colors and file suffixes
export CLICOLOR=1
# See `man ls` on linux for guide to LS_COLORS
# Use theme colors when autocompleting files/folders
export LS_COLORS='no=0:di=34:ln=32:or=32:mi=31:ex=35:st=34:ow=34:tw=34'
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
# See `man ls` on osx for guide to LSCOLORS
# LSCOLORS="excxdxdxfxdxdxfxfxexex"
export LSCOLORS="excxdxdxfxdxdxfxfxexex"

yellow_italic="%{${FG[003]}%}%{${FX[italic]}%}"
white_italic="%{${FG[015]}%}%{${FX[italic]}%}"
red_italic="%{${FG[001]}%}%{${FX[italic]}%}"
purple="%{$FG[004]%}"
gray="%{$FG[007]%}"
white="%{$FG[015]%}"
orange="%{$FG[005]%}"
pale_blue="%{$FG[012]%}"

# >>>
# >>> Prompt
# >>>
local zsh_prompt_prefix="->>"
local zsh_prompt_divider="${orange}❯"

export ZSH_THEME_GIT_PROMPT_DIRTY="${yellow_italic}"
export ZSH_THEME_GIT_PROMPT_CONFLICTED="${red_italic}"
export ZSH_THEME_GIT_PROMPT_CLEAN="${pale_blue}"
export ZSH_THEME_GIT_PROMPT_FORMAT="$ZSH_THEME_GIT_PROMPT_CLEAN"

export GIT_CIRCLE="${gray} "
export GIT_UNTRACKED="${white_italic} "
export GIT_UNSTAGED="${white_italic}δ "
export GIT_STAGED="${white_italic} "

PROMPT='$(_zsh_theme::prompt::prefix)%{${pale_blue}%}$(_zsh_theme::prompt::dir)$(_zsh_theme::prompt::git)$reset '
