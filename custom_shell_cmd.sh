#!/bin/bash

# TODO instead of reading in as global variables, read in every time to a local variable
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

# Writes the directory shortcuts to shortcuts file
gogo_write_shortcuts() {
    echo "${shortcuts[@]}" > ~/custom_shell_cmds/directory_shortcuts.txt
}


gogo () {
    
    protected_vars=( "add" "update" "remove") # These are special keywords that cannot be used as nicknames

    if [[ "$1" == "add" ]]; then
    # Check that the string isn't empty
        if [ -z "$2" ]; then 
            echo "gogo add error: nickname cannot be empty"
            return 1
        fi
        
        # Ensure it's not a protected word
        if [[ protected_vars =~ [[:space:]]${2}[[:space:]] ]]; then 
            echo "gogo add error: nickname cannot be empty"
            return 1
        fi


        shortcuts+=( "$2" )
        shortcuts+=( "$(pwd)" )
        # echo "${shortcuts[@]}"
        gogo_write_shortcuts

    elif [[ "$1" == "update" ]]; then
    # TODO add updating function
        echo "updating"
    elif [[ "$1" == "remove" ]]; then
    # TODO add removing function
    echo "none"
    elif [[ "$1" == "list" ]]; then
    echo "no"
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
gogo add dance