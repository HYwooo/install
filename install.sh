#!/bin/sh

# Pre-install:
# sudo apt update -y && apt install -y curl sudo --quiet --no-install-recommends

# Download and execute the installation script from the specified URL
# curl -sSL https://raw.githubusercontent.com/HYwooo/install/master/install.sh | sudo sh
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/install.sh | sudo sh

# Download and execute the mirror-apt.sh script to configure apt mirrors
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/mirror-apt.sh | sudo sh

# Download and execute the install-zsh.sh script to install Zsh
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/install-zsh.sh | sudo sh

# Download and execute the install-rust.sh script to install Rust
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/install-rust.sh | sudo sh

# Evaluate and execute the x-cmd installation script
eval "$(curl https://get.x-cmd.com)"

# Append a line to .zshrc to source the X file if it exists
echo '[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" ' >>~/.zshrc

# Create the .cargo directory if it doesn't exist
mkdir -p $HOME/.cargo

# Append a line to .zshrc to source the cargo environment
echo '. "$HOME/.cargo/env"' >> ~/.zshrc

# Source the updated .zshrc file using the zsh shell
$(which zsh) -c "source ~/.zshrc"

# Change the default shell to zsh
sudo chsh -s $(which zsh)

# Print a message indicating the installation is complete
echo "******************* Install Finish. ******************"