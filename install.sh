#!/bin/sh
# apt update -y && apt install -y curl sudo --quiet
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/aptmirror.sh | sudo sh
############################################################################################################
apt install -y rustup --no-install-recommends
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/rustmirror.sh | sudo sh
rustup default stable
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/cargomirror.sh | sudo sh
############################################################################################################
eval "$(curl https://get.x-cmd.com)"
echo "[ ! -f \"\$HOME/.x-cmd.root/X\" ] || . \"\$HOME/.x-cmd.root/X\" " >>~/.zshrc
echo ". \"\$HOME/.cargo/env\"" >>~/.zshrc 
chsh -s $(which zsh)
echo "******************* reconnect to apply changes ******************"
