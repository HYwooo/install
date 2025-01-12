#!/bin/sh
# From latest[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@latest/install-zsh.sh | sh
# From master[raw]:
# curl -sSL https://raw.githubusercontent.com/HYwooo/install/refs/heads/master/install-zsh.sh | sh
# From master[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/install-zsh.sh | sh

# Print a blue-colored header indicating the start of Zsh installation
echo -e "\033[1;34m******************* Installing Zsh ******************\033[0m"

# Install Git and Zsh quietly without recommended packages, then set Zsh as the default shell
if ! command -v zsh >/dev/null 2>&1; then
    sudo apt install -y gawk git zsh --quiet --no-install-recommends
    sudo chsh -s "$(which zsh)" "$USER"
    echo -e "\033[1;32m******************* Zsh installed ******************\033[0m"
else
    echo -e "\033[1;33mZsh is already installed, skipping installation.\033[0m"
fi

# Print a blue-colored header indicating the start of Zplug installation
echo -e "\033[1;34m******************* Installing Zplug ******************\033[0m"

# Install Zplug by downloading and running the installation script from the official repository
if [ ! -d ~/.zplug ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    echo -e "\033[1;32m******************* Zplug installed ******************\033[0m"
else
    echo -e "\033[1;33mZplug is already installed, skipping installation.\033[0m"
fi

# Print a blue-colored header indicating the start of Zsh configuration
echo -e "\033[1;34m******************* Configuring Zsh with Zplug ******************\033[0m"

# Create a ~/.zshrc file if it doesn't exist
touch ~/.zshrc

# Add Zplug configuration to ~/.zshrc
if ! grep -q "source ~/.zplug/init.zsh" ~/.zshrc; then
    cat <<EOF >>~/.zshrc
# Zplug configuration
source ~/.zplug/init.zsh

# History config
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Plugins
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting"

# Theme (optional, replace with your preferred theme)
zplug "carloscuesta/materialshell", as:theme, depth:1

# Install plugins if not already installed
if ! zplug check; then
    zplug install
fi

# Load plugins
zplug load

# Environment variables
export TERM=xterm-256color
EOF
    echo -e "\033[1;32m******************* Zsh configured with Zplug ******************\033[0m"
else
    echo -e "\033[1;33mZsh configuration already exists in ~/.zshrc, skipping configuration.\033[0m"
fi

# Reload the ~/.zshrc file to apply the changes
if [ -n "$ZSH_VERSION" ]; then
    source ~/.zshrc
else
    zsh -c "source ~/.zshrc"
fi
