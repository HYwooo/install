#!/bin/sh
# apt update -y && apt install -y curl
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/aptmirror.sh | sudo sh
############################################################################################################
apt install -y gcc g++ rustup
mkdir -p ~/.rustup && rustup default stable
mkdir -p ~/.cargo && mkdir -p ~/.cargo/env
############################################################################################################
apt install -y git zsh fonts-powerline
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/carloscuesta/materialshell.git ~/.oh-my-zsh/custom/themes/materialshell
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="materialshell\/materialshell"/' ~/.zshrc
sed -i 's/^plugins=.*/plugins=(git rust python zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
eval "$(curl https://get.x-cmd.com)"
echo "[ ! -f \"\$HOME/.x-cmd.root/X\" ] || . \"\$HOME/.x-cmd.root/X\" " >>~/.zshrc
echo ". \"\$HOME/.cargo/env\"" >>~/.zshrc && echo "export TERM=xterm-256color" >>~/.zshrc
chsh -s $(which zsh)
echo "******************* reconnect to apply changes ******************"
