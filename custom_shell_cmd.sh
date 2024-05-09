#!/bin/bash

gogo_read_lines() {
    saved_commands=()
    INFILE=~/custom_shell_cmds/directory_shortcuts.txt
    while read -r LINE
        do
        printf '%s\n' "$LINE"
    done < "$INFILE"
}

# A hello world bash function
gogo () {

    if [[ "$1" == "add" ]]; then
    # TODO add adding function
        echo "Im in $(pwd)"
    elif [[ "$1" == "update" ]]; then
    # TODO add updating function
        echo "updating"
    else 
        # Read in
        echo "ga"
    fi

}

gogo_read_lines