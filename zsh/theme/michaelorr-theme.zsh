setopt prompt_subst
setopt interactivecomments

local reset=$'%{\033[0m%}'

GITSTATUS_ENABLED=true
# library for super fast `git status`
if $GITSTATUS_ENABLED && [ -f "$DOT/git/gitstatus/gitstatus.plugin.zsh" ]; then
    source "$DOT/git/gitstatus/gitstatus.plugin.zsh"
    gitstatus_start GSD
else
    GITSTATUS_ENABLED=false
fi

# >>>
# >>> zsh-users/zsh-syntax-highlighting
# >>>
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
typeset -gA ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
export ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
export ZSH_HIGHLIGHT_STYLES[comment]='fg=245'
export ZSH_HIGHLIGHT_STYLES[assign]='fg=14'
export ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=6'
export ZSH_HIGHLIGHT_STYLES[redirection]='fg=6'
export ZSH_HIGHLIGHT_STYLES[path]='fg=6'
export ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=3'
export ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=14'
export ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=11'
export ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=12'
export ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=12'

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
export LS_COLORS="no=38;5;15:fi=38;5;15:di=38;5;14:ex=38;5;5:*.png=38;5;15:*.jpg=38;5;15:*.gif=38;5;15:or=38;5;9:ln=38;5;2:mi=38;5;9:ow=38;5;249"
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
# See `man ls` on osx for guide to LSCOLORS
# LSCOLORS="excxdxdxfxdxdxfxfxexex"
# export LSCOLORS="excxdxdxfxdxdxfxfxexex"

# https://the.exa.website/docs/colour-themes
# /usr/local/dot/tools/spectrum_fg.zsh to see all 256
# export EXA_COLORS="uu=38;5;249:un=38;5;241:gu=38;5;245:gn=38;5;241:da=38;5;245:sn=38;5;7:sb=38;5;7:ur=38;5;3;1:uw=38;5;5;1:ux=38;5;1;1:ue=38;5;1;1:gr=38;5;249:gw=38;5;249:gx=38;5;249:tr=38;5;249:tw=38;5;249:tx=38;5;249:xa=38;5;12"
# export EXA_COLORS="$EXA_COLORS:fi=38;5;15"  # regular files, white
# export EXA_COLORS="$EXA_COLORS:di=38;5;14"  # regular directories, light green
# export EXA_COLORS="$EXA_COLORS:\ex=38;5;5"  # executables, dark orange. The `e` needs escaping, I have no idea why
# export EXA_COLORS="$EXA_COLORS:*.png=38;5;15:*.jpg=38;5;15:*.gif=38;5;15" # images, same as regular files, white
# export EXA_COLORS="$EXA_COLORS:or=38;5;9"   # broken symlinks, pale red

# Below is the concatting of what's above
export EXA_COLORS="uu=38;5;249:un=38;5;241:gu=38;5;245:gn=38;5;241:da=38;5;245:sn=38;5;7:sb=38;5;7:ur=38;5;3;1:uw=38;5;5;1:ux=38;5;1;1:ue=38;5;1;1:gr=38;5;249:gw=38;5;249:gx=38;5;249:tr=38;5;249:tw=38;5;249:tx=38;5;249:xa=38;5;12:fi=38;5;15:di=38;5;14:ex=38;5;5:*.png=38;5;15:*.jpg=38;5;15:*.gif=38;5;15:or=38;5;9"

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

export GIT_CIRCLE="${gray}⋅ "
export GIT_UNTRACKED="${white_italic}⏍ "
export GIT_UNSTAGED="${white_italic}δ "
export GIT_STAGED="${white_italic}⎇ "

PROMPT='$(_zsh_theme::prompt::prefix)%{${pale_blue}%}$(_zsh_theme::prompt::dir)$(_zsh_theme::prompt::git)$reset '




