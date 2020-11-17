if [ -f ~/.zshrc.local ]; then
    . ~/.zshrc.local
fi

# Load dotfiles
#   ~/.custom can be used for settings you don’t want to commit.
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

# Search history by prefix with arrow keys
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
