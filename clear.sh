#!/bin/bash

[[ -z $1 ]] && echo "Provide directory for clearing" && exit

[[ ! -d $1 ]] && echo "Directory not exist!" && exit

for el in `tree $1/ -f -i`; do
    if [[ -f $el ]]; then
        if [[ `file $el | grep ELF` ]]; then
            echo "$el is elf file"
            rm $el
        fi
    fi
done

echo "All ELF files cleared!"
