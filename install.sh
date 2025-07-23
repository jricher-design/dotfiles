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

# Install custom plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
echo "🔌 Installing Oh My Zsh plugins..."

declare -A plugins=(
  ["zsh-nvm"]="https://github.com/lukechilds/zsh-nvm"
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting"
  ["you-should-use"]="https://github.com/MichaelAquilina/zsh-you-should-use"
  ["zsh-bat"]="https://github.com/fdellwing/zsh-bat"
)

for plugin in "${!plugins[@]}"; do
  PLUGIN_DIR="$ZSH_CUSTOM/plugins/$plugin"
  if [ ! -d "$PLUGIN_DIR" ]; then
    echo "📥 Cloning $plugin..."
    git clone --depth=1 "${plugins[$plugin]}" "$PLUGIN_DIR"
  else
    echo "🔁 $plugin already installed."
  fi
done

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

# Attempt to set default shell (optional and may fail in containers)
if command -v chsh >/dev/null 2>&1 && grep -q "/zsh" /etc/shells; then
  echo "🔁 Attempting to set default shell to Zsh (may fail in container)..."
  chsh -s "$(command -v zsh)" || echo "⚠️ chsh failed (expected in containers)."
fi

echo "🎉 Done! Launch a new terminal to use Zsh."