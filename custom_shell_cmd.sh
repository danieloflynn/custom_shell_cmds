#!/bin/bash

# TODO instead of reading in as global variables, read in every time to a local variable
# Reads in the directory shortcuts
gogo_read_shortcuts() {
    shortcuts=() # shortcuts saved in structure ( name0 directory0 name1 directory1 etc )
    INFILE=~/custom_shell_cmds/directory_shortcuts.txt

    while read -ra LINE; do
        shortcuts+=( "${LINE[@]}" ) 
    done < "$INFILE"
}

# Writes the directory shortcuts to shortcuts file
gogo_write_shortcuts() {
    echo "${shortcuts[@]}" > ~/custom_shell_cmds/directory_shortcuts.txt
}


gogo () {
    
    local protected_vars=( "add" "update" "remove") # These are special keywords that cannot be used as nicknames

    if [[ "$1" == "add" ]]; then
    # Check that the string isn't empty
        if [ -z "$2" ]; then 
            echo "gogo add error: nickname cannot be empty."
            return 1
        fi
        
        # Ensure it's not a protected word
        if [[ " ${protected_vars[*]} " =~ [[:space:]]${2}[[:space:]] ]]; then 
            echo "gogo add error: name ${2} is protected."
            return 1
        fi

        # Make sure the nickname doesn't already exist
        if [[ " ${shortcuts[*]} " =~ [[:space:]]${2}[[:space:]] ]]; then 
            echo "gogo add error: name ${2} already exists. Please use \"gogo update\" to overwrite an existing nickname."
            return 1
        fi

        # Add shortcut
        shortcuts+=( "$2" )
        shortcuts+=( "$(pwd)" )
        gogo_write_shortcuts

    elif [[ "$1" == "update" ]]; then
        # Check that the string isn't empty
        if [ -z "$2" ]; then 
            echo "gogo update error: nickname cannot be empty."
            return 1
        fi

        # Iterate over all the shortcuts and if name exists update the shortcut
        local i=0
        while [ "$i" -lt "${#shortcuts[@]}" ]; do
            if [[ "${shortcuts[$i]}" == "$2" ]]; then
                echo "updating ${2} from  ${shortcuts[$i + 1]} to $(pwd)"
                shortcuts[$i + 1]="$(pwd)"
                gogo_write_shortcuts
                return 0
            fi
            i+=2
        done

        echo "gogo update error: name ${2} doesn't exists. Please use \"gogo add\" to add a new nickname."
        return 1
    elif [[ "$1" == "remove" ]]; then
        # TODO add removing function
        # Check that the string isn't empty
        if [ -z "$2" ]; then 
            echo "gogo remove error: nickname cannot be empty."
            return 1
        fi

        # Iterate over all the shortcuts and if name exists remove the shortcut
        local i=0
        local new_shortcuts=()
        local found=0
        while [ "$i" -lt "${#shortcuts[@]}" ]; do
            echo "${shortcuts[$i + 1]}"
            if [[ "${shortcuts[$i]}" == "$2" ]]; then
                found=1
                echo found it
            else
                new_shortcuts+=( "${shortcuts[$i]}" )
                new_shortcuts+=( "${shortcuts[$i + 1]}" )
            fi
            i+=2
        done
        
        if [ "$found" == 0 ]; then
            echo "gogo remove error: name ${2} doesn't exist."
        else 
            shortcuts=( "${new_shortcuts[@]}" ) 
            echo $shortcuts
            gogo_write_shortcuts
        fi


    elif [[ "$1" == "list" ]]; then
    echo "no"
    else 
        local i=0
        while [ "$i" -lt "${#shortcuts[@]}" ]; do
            if [[ "${shortcuts[$i]}" == "$1" ]]; then
                echo "Changing directories to ${shortcuts[$i + 1]}"
                cd 
                cd ${shortcuts[$i + 1]}
                return 0
            fi

            i+=2
        done
    fi

}

gogo_read_shortcuts
gogo remove CS