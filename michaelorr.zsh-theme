PROMPT='%{$fg[red]%}➜ %{$fg[white]%}(%T) $(virtualenv_prompt_info)%{$fg[cyan]%}$USER%{$fg[blue]%}@%{$fg[white]%}$HOSTNAME_ALIAS%{$fg[blue]%}❯ %{$fg[cyan]%}%1/%{$fg[blue]%}$(git_prompt_info)%{$fg[blue]%}❯%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

######################
# Guide for LSCOLORS #
######################

# a     black
# b     red
# c     green
# d     brown
# e     blue
# f     magenta
# g     cyan
# h     light grey

# A     bold black, usually shows up as dark grey
# B     bold red
# C     bold green
# D     bold brown, usually shows up as yellow
# E     bold blue
# F     bold magenta
# G     bold cyan
# H     bold light grey; looks like bright white
# x     default foreground or background


# 1.   directory
# 2.   symbolic link
# 3.   socket
# 4.   pipe
# 5.   executable
# 6.   block special
# 7.   character special
# 8.   executable with setuid bit set
# 9.   executable with setgid bit set
# 10.  directory writable to others, with sticky bit
# 11.  directory writable to others, without sticky bit


export LSCOLORS=gxfxcxdxbxegedabagacad
