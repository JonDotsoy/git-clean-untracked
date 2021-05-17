#!/usr/bin/env bash

#
# git forget script to clear space of files builded or ignored by git.
#
# Author: Jonathan Delgado <hi@jon.soy> (https://jon.soy)
#

function __git-forget__match-expr() {
    arg=$1
    exprignore=(${@:2})

    for e in $exprignore; do
        resultMatch=${arg%%$e}
        if [[ $arg != ${arg%%$e} ]]; then
            return 1
        fi
    done

    return 0
}

function git-forget__remove() {
    file=$1

    if [[ -d $file ]]; then
        rm -r $file
        echo "$file deleted"
    fi

    if [[ -f $file ]]; then
        rm $file
        echo "$file deleted"
    fi
}

function __git-forget__list() {
    fileIgnored=($(git status --ignored -s))
    ignoreforget=(.gitforgetignore .env)

    if [[ -e .gitforgetignore ]]; then
        ignoreforget+=($(cat .gitforgetignore))
    fi

    for ((i = 1; i <= ${#fileIgnored[@]}; i += 2)); do
        fileStatus=${fileIgnored[$i]}
        file=${fileIgnored[(i + 1)]}

        # echo "Pre Status: $fileStatus File: $file"

        if [[ $fileStatus = "!!" ]]; then
            filea=$file
            statusIgnored="$(__git-forget__match-expr $filea $ignoreforget && echo noignored || echo ignored)"
            # echo "\tFilea: ${filea} Status: $fileStatus File: $file Status Ignored: $statusIgnored"

            if [[ $statusIgnored = "noignored" ]]; then
                echo $file
            fi
        fi
    done
}

function git-forget() {
    if [[ $1 = "list-debug" ]]; then
        __git-forget__list
        return 0
    fi

    if [[ $1 = "list" || $1 = "ls" ]]; then
        listFiles=($(__git-forget__list))

        for file in $listFiles; do
            # echo $file
            ls ${@:2} $file
        done
        return 0
    fi

    if [[ $1 = "rm" ]]; then
        listFiles=($(__git-forget__list))

        for file in $listFiles; do
            git-forget__remove $file
        done
        return 0
    fi

    echo 'usage: git-forget <command> [<args>]'
    echo ''
    echo 'Commands:'
    echo '   rm                Memove files'
    echo '   list, ls          List files to remove'
}
