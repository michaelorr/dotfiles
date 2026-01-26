ZVM_INIT_MODE=sourcing
zsh-defer source $DOT/zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh || echo "failed to source zsh-vi-mode"

export ZVM_KEYTIMEOUT=10
export KEYTIMEOUT=10
