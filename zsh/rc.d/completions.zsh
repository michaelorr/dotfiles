#!/usr/bin/env zsh

autoload -Uz compinit

# show menu and highlight current selection
zstyle ':completion:*' menu select

# smart case completions (lower case matches lower and upper)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' format '>>>>> %d'

# COMPLETIONS
#
# https://github.com/zsh-users/zsh/blob/master/Completion/compinstall
# http://zv.github.io/a-review-of-zsh-completion-utilities
# https://askql.wordpress.com/2011/01/11/zsh-writing-own-completion/
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html
# http://mads-hartmann.com/2017/08/06/writing-zsh-completion-scripts.html
# https://github.com/zsh-users/zsh-completions?files=1
# https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
# https://github.com/zsh-users/zsh/blob/master/Completion/Unix/Command/_gnu_generic
# https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
# https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
#
# zplug "zsh-users/zsh-completions"
# https://github.com/zsh-users/zsh-completions
# https://github.com/apjanke/oh-my-zsh-custom/blob/master/lib/completion.zsh
# case insentive complete
# partial completions for multiple dirs
# https://github.com/unixorn/awesome-zsh-plugins#even-more-completions
# prezto "modules/completion"
# https://gist.github.com/ctechols/ca1035271ad134841284
# zstyle ':completion:*:descriptions' format %U%B%d%b%u'
# zstyle ':completion:*:warnings' format '%BSorry,no matches for: %d%b'


#zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

fpath+=/usr/local/share/zsh-completions         # zsh-completions package installed via pkg manager
fpath+=$DOT/zsh/completions                     # one-off completions found in dotfiles
fpath+=/usr/local/share/zsh/site-functions      # zsh completions installed by individual homebrew packages

setopt hash_list_all        # hash everything before completion
setopt complete_aliases     # complete alisases
setopt always_to_end        # when completing from the middle of a word, move the cursor to the end of the word
setopt list_ambiguous       # complete as much of a completion until it gets ambiguous.
setopt complete_in_word     # allow completion from within a word/phrase
setopt menu_complete
setopt auto_param_slash
setopt auto_list



# zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
# zstyle ':completion:*' cache-path ~/.zsh/cache              # cache path
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # ignore case
# zstyle ':completion:*' menu select=2                        # menu if nb items > 2
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
# zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use
#
# # sections completion !
# zstyle ':completion:*' verbose yes
# zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
# zstyle ':completion:*:messages' format $'\e[00;31m%d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*:manuals' separate-sections true
#
zstyle ':completion:*:processes' command 'ps -au$USER'
# zstyle ':completion:*:*:kill:*' menu yes select
# zstyle ':completion:*:kill:*' force-list always
# zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=29=34"
# zstyle ':completion:*:*:killall:*' menu yes select
# zstyle ':completion:*:killall:*' force-list always
# users=(jvoisin root)           # because I don't care about others
# zstyle ':completion:*' users $users

# 16.2.2 Completion
# ALWAYS_LAST_PROMPT <D>
# If unset, key functions that list completions try to return to the last prompt if given a numeric argument. If set these functions try to return to the last prompt if given no numeric argument.
#
# ALWAYS_TO_END
# If a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word. That is, the cursor is moved to the end of the word if either a single match is inserted or menu completion is performed.
#
# AUTO_LIST (-9) <D>
# Automatically list choices on an ambiguous completion.
#
# AUTO_MENU <D>
# Automatically use menu completion after the second consecutive request for completion, for example by pressing the tab key repeatedly. This option is overridden by MENU_COMPLETE.
#
# AUTO_NAME_DIRS
# Any parameter that is set to the absolute name of a directory immediately becomes a name for that directory, that will be used by the ‘%~’ and related prompt sequences, and will be available when completion is performed on a word starting with ‘~’. (Otherwise, the parameter must be used in the form ‘~param’ first.)
#
# AUTO_PARAM_KEYS <D>
# If a parameter name was completed and a following character (normally a space) automatically inserted, and the next character typed is one of those that have to come directly after the name (like ‘}’, ‘:’, etc.), the automatically added character is deleted, so that the character typed comes immediately after the parameter name. Completion in a brace expansion is affected similarly: the added character is a ‘,’, which will be removed if ‘}’ is typed next.
#
# AUTO_PARAM_SLASH <D>
# If a parameter is completed whose content is the name of a directory, then add a trailing slash instead of a space.
#
# AUTO_REMOVE_SLASH <D>
# When the last character resulting from a completion is a slash and the next character typed is a word delimiter, a slash, or a character that ends a command (such as a semicolon or an ampersand), remove the slash.
#
# BASH_AUTO_LIST
# On an ambiguous completion, automatically list choices when the completion function is called twice in succession. This takes precedence over AUTO_LIST. The setting of LIST_AMBIGUOUS is respected. If AUTO_MENU is set, the menu behaviour will then start with the third press. Note that this will not work with MENU_COMPLETE, since repeated completion calls immediately cycle through the list in that case.
#
# COMPLETE_ALIASES
# Prevents aliases on the command line from being internally substituted before completion is attempted. The effect is to make the alias a distinct command for completion purposes.
#
# COMPLETE_IN_WORD
# If unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion is done from both ends.
#
# GLOB_COMPLETE
# When the current word has a glob pattern, do not insert all the words resulting from the expansion but generate matches as for completion and cycle through them like MENU_COMPLETE. The matches are generated as if a ‘*’ was added to the end of the word, or inserted at the cursor when COMPLETE_IN_WORD is set. This actually uses pattern matching, not globbing, so it works not only for files but for any completion, such as options, user names, etc.
#
# Note that when the pattern matcher is used, matching control (for example, case-insensitive or anchored matching) cannot be used. This limitation only applies when the current word contains a pattern; simply turning on the GLOB_COMPLETE option does not have this effect.
#
# HASH_LIST_ALL <D>
# Whenever a command completion or spelling correction is attempted, make sure the entire command path is hashed first. This makes the first completion slower but avoids false reports of spelling errors.
#
# LIST_AMBIGUOUS <D>
# This option works when AUTO_LIST or BASH_AUTO_LIST is also set. If there is an unambiguous prefix to insert on the command line, that is done without a completion list being displayed; in other words, auto-listing behaviour only takes place when nothing would be inserted. In the case of BASH_AUTO_LIST, this means that the list will be delayed to the third call of the function.
#
# LIST_BEEP <D>
# Beep on an ambiguous completion. More accurately, this forces the completion widgets to return status 1 on an ambiguous completion, which causes the shell to beep if the option BEEP is also set; this may be modified if completion is called from a user-defined widget.
#
# LIST_PACKED
# Try to make the completion list smaller (occupying less lines) by printing the matches in columns with different widths.
#
# LIST_ROWS_FIRST
# Lay out the matches in completion lists sorted horizontally, that is, the second match is to the right of the first one, not under it as usual.
#
# LIST_TYPES (-X) <D>
# When listing files that are possible completions, show the type of each file with a trailing identifying mark.
#
# MENU_COMPLETE (-Y)
# On an ambiguous completion, instead of listing possibilities or beeping, insert the first match immediately. Then when completion is requested again, remove the first match and insert the second match, etc. When there are no more matches, go back to the first one again. reverse-menu-complete may be used to loop through the list in the other direction. This option overrides AUTO_MENU.
#
# REC_EXACT (-S)
# If the string on the command line exactly matches one of the possible completions, it is accepted, even if there is another completion (i.e. that string with something else added) that also matches.

# !! https://gist.github.com/ctechols/ca1035271ad134841284
compinit -C
