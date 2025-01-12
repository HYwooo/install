#!/bin/sh

# Pre-install:
# sudo apt update -y && sudo apt install -y curl ca-certificates sudo --quiet --no-install-recommends
#
# From latest[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@latest/install.sh | sh
# From master[raw]:
# curl -sSL https://raw.githubusercontent.com/HYwooo/install/refs/heads/master/install.sh | sh
# From master[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/install.sh | sh

# Download and execute the mirror-apt.sh script to configure apt mirrors
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@latest/mirror-apt.sh | sh

# Download and execute the install-zsh.sh script to install Zsh
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@latest/install-zsh.sh | sh

# Download and execute the install-rust.sh script to install Rust
curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@latest/install-rust.sh | sh

# Evaluate and execute the x-cmd installation script
eval "$(curl https://get.x-cmd.com)"

# Append a line to .zshrc to source the X file if it exists
echo '[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" ' >>~/.zshrc

# Print a message indicating the installation is complete
echo "******************* Install Finish. ******************"
