#!/usr/bin/env zsh
ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}

for code in {000..255}; do
    # FG="\x1b[38;2;RRR;GGG;BBBm" # RGB background
    # FG="\x1b[38;5;NNNm"         # color0-color255 background
    FG="\x1b[39" # default foreground
    print -P -- "$code: $FG %{$BG[$code]%}$ZSH_SPECTRUM_TEXT%{$FX[reset]%}"
done
