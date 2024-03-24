#!/usr/bin/env zsh
ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}

for code in {000..255}; do
    # BG="\x1b[48;2;RRR;GGG;BBBm" # RGB foreground
    # BG="\x1b[48;5;NNNm"         # color0-color255 forground
    BG="\x1b[49" # default background
    print -P -- "$code: $BG %{$FG[$code]$FX[bold]%}$ZSH_SPECTRUM_TEXT%{$FX[reset]%}"
done
