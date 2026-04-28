#!/usr/bin/env bash
# Demonstrate terminal underline style support

printf '\e[4:1mstraight\e[0m  '
printf '\e[4:2mdouble\e[0m  '
printf '\e[4:3mundercurl\e[0m  '
printf '\e[4:4mdotted\e[0m  '
printf '\e[4:5mdashed\e[0m\n'
