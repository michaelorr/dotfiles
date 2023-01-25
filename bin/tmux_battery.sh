#!/usr/bin/env bash
out=$(pmset -g batt)
percent=$(echo $out | grep -o "1\?[0-9]\?[0-9]%")
remaining=$(echo $out | grep -o "[0-9]\+:[0-9]\+ remaining" | cut -d" " -f1)
[[ ! $(echo $out | head -n1 | grep -o "'Battery") ]] && exit 0
(( 80 <= ${percent::-1} )) && echo "#[fg=#57575e]│ #[fg=white]$percent " || rtue
(( 60 <= ${percent::-1} & ${percent::-1} < 80 )) && echo "#[fg=#57575e]│ #[fg=yellow]$percent " || true
(( 40 <= ${percent::-1} & ${percent::-1} < 60 )) && echo "#[fg=#57575e]│ #[fg=orange]$percent " ||true
(( 20 <= ${percent::-1} & ${percent::-1} < 40 )) && echo "#[fg=#57575e]│ #[fg=magenta]$percent -- $remaining " || true
(( ${percent::-1} < 20 )) && echo "#[fg=#57575e]│ #[fg=red]$percent -- $remaining " || true
