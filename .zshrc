if [ -f ~/.zshrc.local ]; then
    . ~/.zshrc.local
fi

# Load dotfiles
#   ~/.local can be used for settings you don’t want to commit.
#   PATH configuration is be done first.
SOURCE_FILES=(
    ~/.path
    ~/.prompt
    ~/.exports
    ~/.aliases
    ~/.functions
    ~/.local
)
for file in ${SOURCE_FILES[@]}; do
    [ -r "$file" ] && [ -f "$file" ] && . "$file";
done
unset file
