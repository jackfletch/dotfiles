#!/bin/bash

# this symlinks all the dotfiles (and .vim/) to ~/
# it also symlinks ~/bin for easy updating

# this is safe to run multiple times and will prompt you about anything unclear

# this is an edit of alrra's nice work here:
#   https://raw.githubusercontent.com/alrra/dotfiles/master/os/create_symbolic_links.sh


cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

create_symlinks() {

    declare -a FILES_TO_SYMLINK=(
        ".bash_aliases"
        "autocomplete/$(get_os)/bash_autocomplete"
        ".bash_exports"
        ".bash_functions"
        ".bash_logout"
        ".bash_options"
        ".bash_profile"
        ".bash_prompt"
        ".bashrc"
        ".curlrc"
        ".inputrc"

        ".gitattributes"
        ".gitconfig"
        ".gitignore"

        ".tmux.conf"

        "vim"
        ".vimrc"
    )

    local i=""
    local sourceFile=""
    local targetFile=""
    local skipQuestions=false

    skip_questions "$@" \
        && skipQuestions=true

    for i in "${FILES_TO_SYMLINK[@]}"; do

        sourceFile="$(pwd)/$i"
        targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        if [ ! -e "$targetFile" ] || $skipQuestions; then
            execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
        elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
            print_success "$targetFile → $sourceFile"
        else
            if ! $skipQuestions; then
                ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                if answer_is_yes; then
                    rm -rf "$targetFile"
                    execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
                else
                    print_error "$targetFile → $sourceFile"
                fi
            fi
        fi
    done
}

main() {
    print_in_purple "\nCreating symbolic links\n\n"
    create_symlinks "$@"
}

main "$@"

