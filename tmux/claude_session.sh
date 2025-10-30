#!/usr/bin/env bash
# Wrapper script to start claude in a tmux session named after the project root

# Source the find_project_root function
source /usr/local/dot/tmux/find_project_root.sh

# Find project root from the provided directory (or current directory)
PROJECT_ROOT=$(find_project_root "${1:-$PWD}")

# Create a session name by replacing / with _
# Also remove leading slash to avoid session names starting with _
SESSION_NAME="claude_$(echo "$PROJECT_ROOT" | sed 's|^/||' | tr '/' '_')"

# Start tmux session at project root
exec tmux new-session -A -s "$SESSION_NAME" -c "$PROJECT_ROOT" /Users/michaelorr/.asdf/shims/claude
