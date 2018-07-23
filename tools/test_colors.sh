#!/usr/bin/env zsh
#
#   This file echoes a bunch of color codes to the 
#   terminal to demonstrate what's available.  Each 
#   line is the color code of one forground color,
#   out of 17 (default + 16 escapes), followed by a 
#   test use of that color on all nine background 
#   colors (default + 8 escapes).
#

T='gYw'   # The test text

echo -e "\n                black    red    green  yellow\
   blue   purple   cyan    white";
echo -e "                 40m     41m     42m     43m\
     44m     45m     46m     47m";


for FGs in "  m  : def " "  1m : bold" "  3m : ital" "  4m :uline" "  0m :hiint" "  1m : bold" \
           "0;30m:black" "1;30m: bold" "3;30m: ital" "4;30m:uline" "0;90m:hiint" "1;90m: bold" \
           "0;31m:  red" "1;31m: bold" "3;31m: ital" "4;31m:uline" "0;91m:hiint" "1;91m: bold" \
           "0;32m:green" "1;32m: bold" "3;32m: ital" "4;32m:uline" "0;92m:hiint" "1;92m: bold" \
           "0;33m: yell" "1;33m: bold" "3;33m: ital" "4;33m:uline" "0;93m:hiint" "1;93m: bold" \
           "0;34m: blue" "1;34m: bold" "3;34m: ital" "4;34m:uline" "0;94m:hiint" "1;94m: bold" \
           "0;35m: purp" "1;35m: bold" "3;35m: ital" "4;35m:uline" "0;95m:hiint" "1;95m: bold" \
           "0;36m: cyan" "1;36m: bold" "3;36m: ital" "4;36m:uline" "0;96m:hiint" "1;96m: bold" \
           "0;37m:white" "1;37m: bold" "3;37m: ital" "4;37m:uline" "0;97m:hiint" "1;97m: bold" ;
    do
        FG=$(echo ${FGs// /} | cut -f1 -d":")
        CODE=$(echo "$FGs" | cut -f1 -d":")
        NAME=$(echo "$FGs" | cut -f2 -d":")
        echo -en "$NAME   \033[$FG $CODE "
        for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
            echo -en "\033[$FG\033[$BG  $CODE \033[0m";
        done
        echo;
    done
echo
