# Print a blue-colored header indicating the start of Zsh installation
echo -e "\033[1;34m******************* Installing Zsh ******************\033[0m"

# Install Git and Zsh quietly without recommended packages, then set Zsh as the default shell, and create a symbolic link from /bin/sh to Zsh
sudo apt install -y git zsh --quiet --no-install-recommends && sudo chsh -s $(which zsh) 

# Add an environment variable to set Zsh as the default shell in the ~/.zshrc file
echo "export SHELL=/usr/bin/zsh" >>~/.zshrc

# Print a green-colored header indicating the completion of Zsh installation
echo -e "\033[1;32m******************* Zsh installed ******************\033[0m"

# Print a blue-colored header indicating the start of Oh My Zsh installation
echo -e "\033[1;34m******************* Installing Oh My Zsh ******************\033[0m"

# Install Oh My Zsh by downloading and running the installation script from the official repository
sh -c "$(curl -fsSL https://gcore.jsdelivr.net/gh/ohmyzsh/ohmyzsh@master/tools/install.sh)"

# Clone the zsh-autosuggestions plugin repository into the Oh My Zsh custom plugins directory
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Clone the zsh-syntax-highlighting plugin repository into the Oh My Zsh custom plugins directory
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Update the Zsh theme to "candy" in the ~/.zshrc file
sudo sed -i 's/^ZSH_THEME=.*/ZSH_THEME="candy"/' ~/.zshrc

# Update the plugins list in the ~/.zshrc file to include Git, Rust, Python, zsh-autosuggestions, and zsh-syntax-highlighting
sudo sed -i 's/^plugins=.*/plugins=(git rust python zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Add an environment variable to set the terminal type to xterm-256color in the ~/.zshrc file
echo "export TERM=xterm-256color" >>~/.zshrc

# Reload the ~/.zshrc file to apply the changes
$(which zsh) -c "source ~/.zshrc"

# Print a green-colored header indicating the completion of Oh My Zsh installation
echo -e "\033[1;32m******************* Oh My Zsh installed ******************\033[0m"
