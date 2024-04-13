FILE="$HOME/.asdf/asdf.sh" && [[ -f "$FILE" ]] && source "$FILE" || true
FILE="$(brew --prefix asdf)/libexec/asdf.sh" && [[ -f "$FILE" ]] && source "$FILE" || true
