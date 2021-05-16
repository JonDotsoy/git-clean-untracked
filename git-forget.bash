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

function git-forget__list() {
    fileIgnored=($(git status --ignored -s))
    ignoreforget=(.gitforgetignore .env)

    if [[ -e .gitforgetignore ]]; then
        ignoreforget+=($(cat .gitforgetignore))
    fi

    for e in $fileIgnored; do
        if [[ $e != "!!" ]]; then
            a=$e
            __git-forget__match-expr $e $ignoreforget && {
                # echo Success $a
                echo $a
            }
        fi
    done
}

function git-forget() {
    listFiles=($(git-forget__list))

    if [[ $1 = "list" || $1 = "ls" ]]; then
        for file in $listFiles; do
            ls ${@:2} $file
        done
        return 0
    fi

    if [[ $1 = "rm" ]]; then
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
