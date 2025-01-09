echo -e "\033[1;34m******************* Installing Zsh ******************\033[0m"
sudo apt install -y git zsh --quiet --no-install-recommends && sudo chsh -s $(which zsh) && sudo ln -s $(which zsh) /bin/sh
echo "export SHELL=/usr/bin/zsh" >>~/.zshrc
echo -e "\033[1;32m******************* Zsh installed ******************\033[0m"
echo -e "\033[1;34m******************* Installing Oh My Zsh ******************\033[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo sed -i 's/^ZSH_THEME=.*/ZSH_THEME="candy"/' ~/.zshrc
sudo sed -i 's/^plugins=.*/plugins=(git rust python zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
echo "export TERM=xterm-256color" >>~/.zshrc
source ~/.zshrc
echo -e "\033[1;32m******************* Oh My Zsh installed ******************\033[0m"
