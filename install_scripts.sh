#!bin/sh

brew list "gum" > /dev/null || brew install "gum"

LOCATION="\$HOME/dotfiles/bin"

# echo command that tells user to add bin to their path
echo "\nAdd the following to your path: $LOCATION\n"
echo "in fish, just run: fish_add_path $LOCATION"
echo "in zsh, add this to your .zshrc: path+=(\"$LOCATION\")"

echo "\nIf you cannot run any commands, try the following:"
echo "chmod u+x $LOCATION/*"
