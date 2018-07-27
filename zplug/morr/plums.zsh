#!/usr/bin/env zsh

setopt cdable_vars
plums=$SRC/mailchimp/app/lib/Plums

function plums() {
	case "$1" in
	'')
		;&
	'cd')
		cd /Users/morr/src/mailchimp
	    cd mailchimp || exit 1
	    cd app/lib/Plums || exit 1
	    ;;
	'shell')
	    cd mailchimp || exit 1
	    ./script/plums shell
	    cd - || return
	    ;;
	'test')
	    cd mailchimp || exit 1
	    if [ -n "$2" ]; then
	        find app/lib/Plums tests/unit/Plums -not -name "*.swp" | entr -cs "find tests/unit/Plums -iname \"*$2*\" -not -name \"*.swp\" | tee /dev/tty | xargs -L1 ./script/run-tests"
	    else
	        find app/lib/Plums tests/unit/Plums -not -name "*.swp" | entr -cs "find tests/unit/Plums -iname \"*$2*\" -not -name \"*.swp\" | xargs ./script/run-tests"
	    fi
	    cd - || exit 1
	    ;;
	'help')
	    ;&
	*)
		# http://docopt.org/
	    cat <<-HEREDOC
		Usage:
			plums shell
		    plums cd
		    plums test [filter]
		    plums help
		HEREDOC
	    ;;
	esac
}

# vim: set noexpandtab:
