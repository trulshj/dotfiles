#!/bin/sh

echo "Ah shieeet, here we go again"

echo "Open sesame:"
sudo -v

if test ! $(which brew); then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Updating Homebrew..."
brew update

echo "Installing all dependencies..."
brew tap homebrew/bundle
brew bundle

echo "Setting up .gitconfig..."
ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig

echo "Installing oh-my-zsh..."
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
ln -s $HOME/dotfiles/zsh/aliases.zsh $ZSH_CUSTOM/aliases.zsh
ln -s $HOME/dotfiles/zsh/paths.zsh $ZSH_CUSTOM/paths.zsh
ln -s $HOME/dotfiles/zsh/vars.zsh $ZSH_CUSTOM/vars.zsh

echo "Installing Node LTS..."
sudo n lts

echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup toolchain install stable
rustup default stable

echo "Settup up tmux..."
ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Setting up nvim..."
ln -s $HOME/dotfiles/nvim/ $HOME/.config/nvim

echo "Setting Apple Defaults..."
defaults write com.apple.finder CreateDesktop false
defaults write com.apple.finder ShowPathbar true
defaults write com.apple.finder AppleShowAllFiles true
defaults write com.apple.finder ShowStatusBar true
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
killall Finder
