#!/bin/bash

# A hello world bash function
gogo () {
    # Read in the file
    command=$1
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

  saved_commands=()

}