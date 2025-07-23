#!/bin/bash

# Exit immediately if a command fails
set -e

echo "🔧 Setting up Zsh..."

# Install Oh My Zsh (non-interactive)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh already installed."
fi

# Copy .zshrc
echo "📄 Copying .zshrc to $HOME"
cp ~/.dotfiles/.zshrc ~/.zshrc

# Set default shell to Zsh (optional; no effect inside container sessions)
if command -v chsh >/dev/null 2>&1; then
  chsh -s "$(which zsh)" || true
fi

echo "🎉 Done! Launch a new terminal to use Zsh."