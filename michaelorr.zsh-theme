PROMPT='%{$fg_bold[red]%}➜ $(virtualenv_prompt_info)%{$fg[yellow]%}$USER%{$fg[blue]%}@%{$fg[white]%}$HOSTNAME_ALIAS %{$fg_bold[blue]%}❯ %{$fg_bold[green]%}%p%{$fg[cyan]%}%1/ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}❯%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
