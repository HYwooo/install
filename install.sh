#!/bin/sh
# apt update -y && apt install -y curl sudo --quiet
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/mirror-apt.sh | sudo sh
############################################################################################################
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/install-rust.sh | sudo sh
############################################################################################################
eval "$(curl https://get.x-cmd.com)"
echo '[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" ' >>~/.zshrc
mkdir -p $HOME/.cargo
echo '. "$HOME/.cargo/env"' >> ~/.zshrc
/usr/bin/zsh -c "source ~/.zshrc"
sudo chsh -s $(which zsh)
echo "******************* reconnect to apply changes ******************"
