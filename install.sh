#!/bin/sh

echo "Ah shieeet, here we go again"

echo "Open sesame:"
sudo -v

if test ! $(which brew); then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "Updating Homebrew..."
brew update

echo "Installing all dependencies..."
brew tap homebrew/bundle
brew bundle

echo "Setting up .gitconfig..."
ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -s $HOME/dotfiles/zsh/aliases.zsh $ZSH_CUSTOM/aliases.zsh
ln -s $HOME/dotfiles/zsh/paths.zsh $ZSH_CUSTOM/paths.zsh

echo "Installing Node LTS..."
sudo n lts

echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup toolchain install stable
rustup default stable

echo "Installing yabai & skhd..."
ln -s $HOME/dotfiles/.yabairc $HOME/.yabairc
ln -s $HOME/dotfiles/.skhdrc $HOME/.skhdrc
yabai --start-service
skhd --start-service

echo "Settup up tmux..."
ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Setting up sketchybar..."
ln -s $HOME/dotfiles/sketchybar $HOME/.config/sketchybar
brew services start sketchybar

echo "Setting up nvim..."
ln -s $HOME/dotfiles/nvim/ $HOME/.config/nvim
