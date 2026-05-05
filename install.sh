#!/bin/sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_BREWFILE=0

show_help() {
  cat <<EOF
Usage: sh install.sh [options]

Options:
  --install-brewfile, --with-brewfile  Install packages from Brewfile
  --skip-brewfile                       Skip Brewfile installation (default)
  -h, --help                            Show this help message and exit
EOF
}

for arg in "$@"; do
  case "$arg" in
    --install-brewfile|--with-brewfile)
      INSTALL_BREWFILE=1
      ;;
    --skip-brewfile)
      INSTALL_BREWFILE=0
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo "Unknown option: $arg"
      echo
      show_help
      exit 1
      ;;
  esac
done

echo "Open sesame:"
sudo -v

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Updating Homebrew..."
brew update

if [ "$INSTALL_BREWFILE" -eq 1 ]; then
  echo "Installing all dependencies..."
  brew bundle --file "$DOTFILES_DIR/Brewfile"
else
  echo "Skipping Brewfile installation by default. Use --install-brewfile to enable."
fi

echo "Setting up .gitconfig..."
ln -snf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

echo "Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
ln -snf "$DOTFILES_DIR/zsh/aliases.zsh" "$ZSH_CUSTOM_DIR/aliases.zsh"
ln -snf "$DOTFILES_DIR/zsh/paths.zsh" "$ZSH_CUSTOM_DIR/paths.zsh"
ln -snf "$DOTFILES_DIR/zsh/vars.zsh" "$ZSH_CUSTOM_DIR/vars.zsh"

echo "Installing Node LTS..."
if command -v node >/dev/null 2>&1; then
  echo "Node already installed ($(node -v)); skipping n lts."
elif command -v n >/dev/null 2>&1; then
  sudo n lts
else
  echo "'n' is not installed; skipping Node LTS install."
fi

echo "Installing Rust..."
if command -v rustup >/dev/null 2>&1 && command -v rustc >/dev/null 2>&1; then
  echo "Rust already installed ($(rustc --version)); skipping rustup bootstrap."
else
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
if command -v rustup >/dev/null 2>&1; then
  rustup toolchain install stable
  rustup default stable
else
  echo "rustup not found; skipping Rust toolchain setup."
fi

echo "Setting up tmux..."
ln -snf "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"
if command -v tmux >/dev/null 2>&1; then
  echo "tmux already installed ($(tmux -V)); skipping tmux install."
else
  echo "tmux not found; install it via Brewfile or Homebrew."
fi
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "tmux TPM already present; skipping clone."
fi

echo "Setting up nvim..."
mkdir -p "$HOME/.config"
if [ -L "$DOTFILES_DIR/nvim/nvim" ]; then
  NVIM_SELF_LINK_TARGET="$(readlink "$DOTFILES_DIR/nvim/nvim" || true)"
  if [ "$NVIM_SELF_LINK_TARGET" = "$DOTFILES_DIR/nvim" ] || [ "$NVIM_SELF_LINK_TARGET" = "$DOTFILES_DIR/nvim/" ]; then
    echo "Removing self-referential symlink at $DOTFILES_DIR/nvim/nvim"
    rm -f "$DOTFILES_DIR/nvim/nvim"
  fi
fi
ln -snf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

echo "Setting Apple Defaults..."
defaults write com.apple.finder CreateDesktop false
defaults write com.apple.finder ShowPathbar true
defaults write com.apple.finder AppleShowAllFiles true
defaults write com.apple.finder ShowStatusBar true
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
killall Finder
