#!/bin/bash

# Reads in the directory shortcuts
gogo_read_shortcuts() {
    shortcuts=() # shortcuts saved in structure ( name0 directory0 name1 directory1 etc )
    INFILE=~/custom_shell_cmds/directory_shortcuts.txt
    while read -ra LINE; do
        # echo ${LINE[1]}
        shortcuts+=( "${LINE[@]}" ) 
    done < "$INFILE"
    # for i in "${shortcuts[@]}"; do
    # echo "$i"
    # done
}

# Writes the directory shortcuts to a file
gogo_write_lines() {
    echo "hello"
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
        i=0
        while [ "$i" -lt "${#shortcuts[@]}" ]; do
            if [[ "${shortcuts[$i]}" == "$1" ]]; then
                echo "Changing directories to ${shortcuts[$i + 1]}"
                cd 
                cd ${shortcuts[$i + 1]}
                break
            fi

            i+=2
        done
    fi

}

gogo_read_shortcuts