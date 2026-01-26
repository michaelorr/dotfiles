export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
local asdf_completion=~/.zsh_asdf_completion
local -a old_asdf_completion=($asdf_completion(N.mh+24))
if [[ ! -f $asdf_completion ]] || (( ${#old_asdf_completion} )); then
  asdf completion zsh > $asdf_completion
fi
zsh-defer source $asdf_completion
