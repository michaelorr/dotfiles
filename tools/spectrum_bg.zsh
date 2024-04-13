#!/usr/bin/env zsh

# usage:
# ./spectrum_bg.zsh
# fg=122 ./spectrum_bg.zsh
# g=14 b=72 ./spectrum_bg.zsh
# r=12 g=14 b=72 ./spectrum_bg.zsh

ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}
FG_RESET="\x1b[39" # RESET TO DEFAULT
[[ ! -z $fg ]] && FG_OVERRIDE='\x1b[38;5;${fg}m'            # FG="\x1b[38;5;NNNm"         # color0-color255 foreground
if [[ ! -z $r || ! -z $b || ! -z $g ]]; then
    r=${r:-0}
    b=${b:-0}
    g=${g:-0}
    FG_OVERRIDE='\x1b[38;2;${r};${g};${b}m'   # FG="\x1b[38;2;RRR;GGG;BBBm" # RGB foreground
fi

for code in {000..255}; do
    print -P -- "$code %{$FG_RESET$FG_OVERRIDE$BG[$code]%}$ZSH_SPECTRUM_TEXT%{$FX[reset]%}"
done
