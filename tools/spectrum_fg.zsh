#!/usr/bin/env zsh

# usage:
# ./spectrum_fg.zsh
# bg=122 ./spectrum_fg.zsh
# r=12 b=72 ./spectrum_fg.zsh
# r=12 b=72 g=12 ./spectrum_fg.zsh

ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}
BG_RESET="\x1b[49" # RESET TO DEFAULT

# BG="\x1b[48;5;NNNm"         # color0-color255 background
[[ ! -z $bg ]] && BG_OVERRIDE='\x1b[48;5;${bg}m'

# BG="\x1b[48;2;RRR;GGG;BBBm" # RGB background
if [[ ! -z $r || ! -z $b || ! -z $g ]]; then
    r=${r:-0}
    b=${b:-0}
    g=${g:-0}
    BG_OVERRIDE='\x1b[48;2;${r};${g};${b}m'
fi

for code in {000..255}; do
    print -P -- "$code: %{$BG_RESET$BG_OVERRIDE$FG[$code]$FX[bold]%}$ZSH_SPECTRUM_TEXT%{$FX[reset]%}"
done
