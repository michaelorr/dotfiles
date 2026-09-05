#!/bin/bash

input=$(cat)

# One jq pass for everything. Rate limit fields only exist for Pro/Max accounts, and only after the
# first API response in a session, so every access needs a default. Percentages arrive as floats.
IFS=$'\t' read -r MODEL CWD CTX_PCT VIM_MODE < <(
  echo "$input" | jq -r '[
    (.model.display_name // "?" | split(" ")[0]),
    (.cwd // ""),
    ((.context_window.used_percentage // 0) | floor),
    (.vim.mode // "" | ascii_upcase)
  ] | @tsv'
)

CYAN='\033[36m'
MAGENTA='\033[35m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
BOLD='\033[1m'
DIM='\033[2m'
GRAY='\033[38;5;235m'
RESET='\033[0m'
BAR_BG='\033[48;5;233m'

# which glyph set make_bar draws with: braille, boxes, or circles
BAR_STYLE='braille'

# make_bar PCT [STYLE]
# Prints a percentage as a 5 cell bar. Braille and boxes resolve to an eighth of a cell (2.5%) and
# sit on a dark background so the unfilled part of a partial cell reads as track; circles resolve to
# a quadrant (5%) and use hollow circles instead. A non-zero percentage always shows at least one
# tick so the bar never reads as absent.
# Color thresholds: green < 70%, yellow >= 70%, red >= 90%.
make_bar() {
  local pct=$1
  local style=${2:-$BAR_STYLE}
  local steps ladder full_glyph empty_glyph bg empty_fg

  case "$style" in
  circles)
    steps=4
    full_glyph="●"
    empty_glyph="○"
    bg=""
    empty_fg="$GRAY"
    ladder=("" "◔" "◑" "◕")
    ;;
  boxes)
    steps=8
    full_glyph="█"
    empty_glyph=" "
    bg="$BAR_BG"
    empty_fg="$DIM"
    ladder=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉")
    ;;
  *)
    steps=8
    full_glyph="⣿"
    empty_glyph=" "
    bg="$BAR_BG"
    empty_fg="$DIM"
    ladder=("" "⡀" "⡄" "⡆" "⡇" "⣇" "⣧" "⣷")
    ;;
  esac

  local color
  if [ "$pct" -ge 90 ]; then
    color="$RED"
  elif [ "$pct" -ge 70 ]; then
    color="$YELLOW"
  else color="$GREEN"; fi

  local units=$(((pct * 5 * steps + 50) / 100))
  [ "$units" -eq 0 ] && units=1
  local full=$((units / steps))
  local partial=$((units % steps))

  local filled="" empty="" i
  for ((i = 0; i < full; i++)); do filled+="$full_glyph"; done
  [ "$partial" -gt 0 ] && filled+="${ladder[$partial]}"
  for ((i = full + (partial > 0 ? 1 : 0); i < 5; i++)); do empty+="$empty_glyph"; done

  echo -e "${bg}${color}${filled}${empty_fg}${empty}${RESET}"
}

# Mode block modeled on lualine's section a from nvim/lua/plugins/specs/ui.lua, with abbreviations
# from that file's modestr(). Normal and insert use the basic ansi colors so they track the terminal
# theme; visual and replace use 256-color indices matching what nvim renders (it runs with
# termguicolors off, so lualine rounds the theme hex to the palette). Modes with no theme entry
# (command, select, terminal) fall back to the normal colors like lualine does.
VIM_SEG=""
if [ -n "$VIM_MODE" ]; then
  MODE_FG='\033[38;5;233m'
  MODE_NORMAL_BG='\033[42m'
  case "$VIM_MODE" in
  NORMAL)
    MODE_ABBR="N"
    MODE_BG="$MODE_NORMAL_BG"
    ;;
  INSERT)
    MODE_ABBR="I"
    MODE_BG='\033[44m'
    ;;
  REPLACE)
    MODE_ABBR="R"
    MODE_BG='\033[48;5;203m'
    ;;
  *"VISUAL BLOCK"* | V-B)
    MODE_ABBR="V-B"
    MODE_BG='\033[48;5;208m'
    ;;
  *"VISUAL LINE"* | V-L)
    MODE_ABBR="V-L"
    MODE_BG='\033[48;5;208m'
    ;;
  VISUAL*)
    MODE_ABBR="V"
    MODE_BG='\033[48;5;208m'
    ;;
  COMMAND)
    MODE_ABBR="C"
    MODE_BG="$MODE_NORMAL_BG"
    ;;
  SELECT*)
    MODE_ABBR="S"
    MODE_BG="$MODE_NORMAL_BG"
    ;;
  TERMINAL)
    MODE_ABBR="T"
    MODE_BG="$MODE_NORMAL_BG"
    ;;
  *)
    MODE_ABBR="${VIM_MODE:0:1}"
    MODE_BG="$MODE_NORMAL_BG"
    ;;
  esac
  VIM_SEG="${MODE_BG}${MODE_FG}${BOLD} ${MODE_ABBR} ${RESET}"
fi

# Directory display mirroring __ps_dirpath from dotfiles/zsh/funcs/promptutil: outside a git repo
# show the plain path in cyan, inside one show magenta @repo:relpath where repo is the tail of the
# origin url minus its extension (overridable with `git config repo.name`) and relpath is the path
# relative to the repo root, or ~ at the root itself.
GIT_ORIGIN=$(git --no-optional-locks -C "$CWD" remote get-url origin 2>/dev/null)
if [ -z "$GIT_ORIGIN" ]; then
  DIR_SEG="${CYAN}${CWD/#$HOME/\~}${RESET}"
else
  REPO_NAME=$(git --no-optional-locks -C "$CWD" config --get repo.name 2>/dev/null)
  [ -n "$REPO_NAME" ] && GIT_ORIGIN="$REPO_NAME"
  ORIGIN_TAIL="${GIT_ORIGIN##*/}"
  RELPATH=$(git --no-optional-locks -C "$CWD" rev-parse --show-prefix 2>/dev/null)
  RELPATH="${RELPATH%/}"
  DIR_SEG="${MAGENTA}@${ORIGIN_TAIL%.*}:${RELPATH:-~}${RESET}"
fi

# detached heads fall back to the short sha
BRANCH=$(git --no-optional-locks -C "$CWD" branch --show-current 2>/dev/null)
[ -z "$BRANCH" ] && BRANCH=$(git --no-optional-locks -C "$CWD" rev-parse --short HEAD 2>/dev/null)
BRANCH_SEG="${BRANCH:+${GREEN}⎇ ${BRANCH}${RESET}}"

GIT_STATUS=""
if git rev-parse --git-dir >/dev/null 2>&1; then
  STAGED=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
  MODIFIED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')
  UNTRACKED=$(git ls-files --others --exclude-standard | wc -l | tr -d ' ')

  GIT_STATUS=""
  [ "$STAGED" -gt 0 ] && GIT_STATUS="${GREEN}^${STAGED}${RESET}"
  [ "$MODIFIED" -gt 0 ] && GIT_STATUS="${GIT_STATUS}${YELLOW}~${MODIFIED}${RESET}"
  [ "$UNTRACKED" -gt 0 ] && GIT_STATUS="${GIT_STATUS}${GREEN}+${UNTRACKED}${RESET}"
fi

CTX_SEG="$(make_bar "$CTX_PCT")"

echo -e "${VIM_SEG:+${VIM_SEG}} ${YELLOW}${BOLD}[$MODEL]${RESET} ${CTX_SEG} ${DIR_SEG}${BRANCH_SEG:+ ${BRANCH_SEG}}${GIT_STATUS:+ ${GIT_STATUS}}"
