#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f /apollo/env/envImprovement/var/bashrc ]; then
    . /apollo/env/envImprovement/var/bashrc
fi

for env in SDETools envImprovement AmazonAwsCli OdinTools; do
    if [[ -d /apollo/env/$env ]]; then
        export PATH=$PATH:/apollo/env/$env/bin
    fi
done

# Load dotfiles
#   ~/.custom can be used for settings you don't want to commit.
#   PATH configuration is be done first.
SOURCE_FILES=(
    ~/.path
    ~/.prompt
    ~/.exports
    ~/.aliases
    ~/.functions
    ~/.custom
)
for file in ${SOURCE_FILES[@]}; do
    [ -r "$file" ] && [ -f "$file" ] && . "$file";
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Autocorrect on directory names to match a glob.
shopt -s dirspell 2> /dev/null;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
#
# Adopted from https://github.com/danemacmillan/dotfiles/blob/46650938/home/.bashrc#L221-L264.
#
# Note that these dotfiles expect `bash_completion@2`, which fully leverages
# non-eager completion loading from the core library, as well as using the user
# path at ${XDG_DATA_HOME}/bash-completion/completions. That path can be used to
# override any non-eager completion by simply creating a file that matches the
# utility's name.
#
# Read: https://github.com/scop/bash-completion#faq
#
# Add `time` to beginning of source line to see real time.
#
# For MacOS, use homebrew's `bash-completion@2` package, which is significantly
# faster than original `bash-completion` package.
# Read: https://superuser.com/a/1393343/496301
#
# This completion sourcing exclusively support version 2, and provides
# fallback support for any utilities that have not updated, using the
# `$BASH_COMPLETION_COMPAT_DIR` path. Multiple locations are searched: the
# usual MacOS path is first checked, then a common path on Linux systems.
#
# Additionally, the $BASH_COMPLETION_USER_FILE environment variable is set,
# which by default points to `~/.bash_completion`, but instead has been moved to
# an XDG directory. Note that this user file is sourced eagerly as well, so
# should not be used, except in cases where a popular tool does not offer a
# better alternative. For the purpose of distinguishing old-style eager
# completions from modern non-eager completions, this user completion file has
# been added to a path under $XDG_CONFIG_HOME.
#
# Non-eager user completions are available under the new path, under
# $XDG_DATA_HOME. This is where all new completions should be added. Note that
# it is hardcoded to look in a "completions" subdirectory of
# $BASH_COMPLETION_USER_DIR, so in this configuration, the path would expand
# to $BASH_COMPLETION_USER_DIR/completions.
export BASH_COMPLETION_USER_DIR="${XDG_DATA_HOME}/bash-completion"
export BASH_COMPLETION_USER_FILE="${XDG_CONFIG_HOME}/bash-completion/bash_completion"
if [ -r /usr/local/etc/profile.d/bash_completion.sh ]; then
    export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d";
    source /usr/local/etc/profile.d/bash_completion.sh;
elif [ -r /etc/profile.d/bash_completion.sh ]; then
    export BASH_COMPLETION_COMPAT_DIR="/etc/bash_completion.d";
    source /etc/profile.d/bash_completion.sh;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
#
# In case git completions are non-eagerly loaded and have not been sourced yet,
# load git's `__git_complete` and call `__git_complete g git`. This is done
# using bash-completion's `_xfunc` utility function.
# See: https://github.com/scop/bash-completion/blob/895386de/bash_completion#L2717-L2733
if type _xfunc &> /dev/null; then
    _xfunc git __git_complete g git;
fi;

# Enable tab completion for `k` by marking it as an alias for `kubectl`
if type __start_kubectl &> /dev/null; then
    complete -o default -F __start_kubectl k
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Append to history, don't overwrite it
type shopt &> /dev/null && shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Hooking into other apps
export NVM_DIR="$HOME/.nvm"
# export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"


# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

