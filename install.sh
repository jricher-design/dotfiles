#!/bin/bash

# Exit immediately if a command fails
set -e

echo "🔧 Setting up Zsh..."

# Environment variables to prevent interactive prompts
export CHSH=no
export RUNZSH=no
export KEEP_ZSHRC=yes

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh already installed."
fi

# Copy .zshrc only if it doesn't already exist or differs
ZSHRC_SOURCE="$HOME/.dotfiles/.zshrc"
ZSHRC_TARGET="$HOME/.zshrc"

echo "📄 Copying .zshrc to $ZSHRC_TARGET"
if [ ! -f "$ZSHRC_TARGET" ] || ! cmp -s "$ZSHRC_SOURCE" "$ZSHRC_TARGET"; then
  cp "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
  echo "✅ .zshrc copied."
else
  echo "🟡 .zshrc already up to date."
fi

# Set default shell to zsh (usually not effective in containers, but harmless)
if command -v chsh >/dev/null 2>&1 && grep -q "/zsh" /etc/shells; then
  echo "🔁 Attempting to set default shell to Zsh (may fail in container)..."
  chsh -s "$(command -v zsh)" || echo "⚠️ chsh failed (expected in containers)."
fi

echo "🎉 Done! Launch a new terminal to use Zsh."