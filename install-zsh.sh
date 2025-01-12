#!/bin/sh
# From latest[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@latest/install-zsh.sh | sh
# From master[raw]:
# curl -sSL https://raw.githubusercontent.com/HYwooo/install/refs/heads/master/install-zsh.sh | sh
# From master[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/install-zsh.sh | sh

echo -e "\033[1;34m******************* Installing Zsh ******************\033[0m"

# Install Git and Zsh quietly without recommended packages, then set Zsh as the default shell
sudo apt install -y gawk git zsh --quiet --no-install-recommends && chsh -s $(which zsh) $USER
echo -e "\033[1;32m******************* Zsh installed ******************\033[0m"

echo -e "\033[1;34m******************* Installing Zplug ******************\033[0m"
# Install Zplug by downloading and running the installation script from the official repository
curl -sL --proto-redir -all,https https://gcore.jsdelivr.net/gh/zplug/installer@master/installer.zsh | zsh
echo -e "\033[1;32m******************* Zplug installed ******************\033[0m"


echo -e "\033[1;34m******************* Configuring Zsh with Zplug ******************\033[0m"
# Create a ~/.zshrc file if it doesn't exist
touch ~/.zshrc

# Add Zplug configuration to ~/.zshrc
cat <<EOF >>~/.zshrc
# Zplug configuration
source ~/.zplug/init.zsh

# History config
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Plugins
# zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting"
# zplug "zpm-zsh/ls"
# zplug "plugins/docker", from:oh-my-zsh
# zplug "plugins/composer", from:oh-my-zsh
# zplug "plugins/extract", from:oh-my-zsh
# zplug "lib/completion", from:oh-my-zsh
# zplug "plugins/sudo", from:oh-my-zsh
# zplug "b4b4r07/enhancd", use:init.sh

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

# Reload the ~/.zshrc file to apply the changes
$(which zsh) -c "source ~/.zshrc"

# Print a green-colored header indicating the completion of Zsh configuration
echo -e "\033[1;32m******************* Zsh configured with Zplug ******************\033[0m"
