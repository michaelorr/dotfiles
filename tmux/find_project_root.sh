#!/usr/bin/env bash
# Find the nearest project root by looking for .git or .claude directories
# Handles symlinks by resolving to real paths first

find_project_root() {
    # Resolve symlinks to get the real path
    # realpath is available on macOS 12.3+ and most Linux distros
    # On older systems, this falls back to pwd -P which is POSIX-compliant
    local dir
    if command -v realpath >/dev/null 2>&1; then
        dir=$(realpath "${1:-$PWD}" 2>/dev/null)
    else
        # Fallback for systems without realpath (older macOS)
        dir=$(cd "${1:-$PWD}" && pwd -P)
    fi

    # Walk up the directory tree looking for project markers
    # Stop at root or home directory
    while [[ "$dir" != "/" ]] && [[ "$dir" != "$HOME" ]]; do
        if [[ -d "$dir/.git" ]] || [[ -d "$dir/.claude" ]]; then
            echo "$dir"
            return 0
        fi
        dir=$(dirname "$dir")
    done

    # Fallback to the original directory if no project root found
    echo "${1:-$PWD}"
}

# If called directly, output the project root
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    find_project_root "$@"
fi
