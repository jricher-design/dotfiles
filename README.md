# dotfiles

Personal Zsh configuration and setup scripts.

## Features

- Automated installation of [Oh My Zsh](https://ohmyz.sh/)
- Custom `.zshrc` with plugins:
  - `git`
  - `nvm`, `zsh-nvm`
  - `zsh-autosuggestions`
  - `zsh-syntax-highlighting`
  - `you-should-use`
  - `zsh-bat`
- Optional automatic switching to Zsh as the default shell

## Installation

Clone this repository to your home directory:

```sh
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
```

Run the install script:

```sh
cd ~/.dotfiles
./install.sh
```

This will:

- Install Oh My Zsh (if not already installed)
- Copy the custom `.zshrc` to your home directory
- Optionally set Zsh as your default shell

## Customization

Edit `~/.dotfiles/.zshrc` to add aliases, change plugins, or update your theme.

## Notes

- The install script is idempotent and safe to run multiple times.
- For custom plugins, add them to the `plugins` array in `.zshrc`.

---
Inspired by [Oh My Zsh](https://ohmyz.sh/) and the dotfiles