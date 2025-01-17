#!/bin/sh

# Install Rust and set up environment variables
# This script installs Rust and configures it to use a mirror if access to Google is blocked.
# From latest[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@latest/install-rust.sh | sh
# From master[raw]:
# curl -sSL https://raw.githubusercontent.com/HYwooo/install/refs/heads/master/install-rust.sh | sh
# From master[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/install-rust.sh | sh
# Install necessary dependencies
sudo apt install -y coreutils ca-certificates gcc g++ --quiet --no-install-recommends

# Check if Google is accessible (to determine network connectivity)
if [ "$USE_MIRROR" != "1" ] && timeout 1 curl -s -o /dev/null https://www.google.com; then

    sudo apt install rustup -y --quiet
    # zsh -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # Set the default Rust toolchain to stable
    rustup default stable

    # Create the .cargo directory if it doesn't exist
    mkdir -p $HOME/.cargo
    touch $HOME/.zshrc
    touch $HOME/.cargo/env
    # Add Rust environment variables to .zshrc
    echo '. "$HOME/.cargo/env"' >>$HOME/.zshrc
    # echo '. "$HOME/.cargo/env"' >>$HOME/.bashrc
    
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >>$HOME/.cargo/env

    # Reload the shell configuration
    zsh -c "source ~/.zshrc"
else
    # If Google is not accessible, print an error message and use a mirror
    echo -e "\033[131mTimeout: Unable to access Google.\033[0m"
    echo -e "\033[134m******************* Setting Rustup mirror: TSINGHUA ******************\033[0m"

    # Set environment variables to use the Tsinghua University mirror for Rustup
    $(which zsh) -c "export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup"
    $(which zsh) -c "export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup"

    # Add the mirror settings to .zshrc for persistence
    echo "export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup" >>~/.zshrc
    echo "export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup" >>~/.zshrc

    # Reload the shell configuration
    touch $HOME/.zshrc
    zsh -c "source ~/.zshrc"

    # Install Rust using the Tsinghua mirror
    sudo apt install rustup -y --quiet
    #$(which zsh) -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # Print a success message
    echo -e "\033[1;32m******************* Rustup mirror set:    TSINGHUA    ******************\033[0m"

    # Set the default Rust toolchain to stable
    rustup default stable

    # Create the .cargo directory if it doesn't exist
    mkdir -p $HOME/.cargo

    # Add Rust environment variables to .zshrc
    
    touch $HOME/.cargo/env
    echo '. "$HOME/.cargo/env"' >>$HOME/.zshrc
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >>$HOME/.cargo/env

    # Configure Cargo to use the Tsinghua mirror for crates.io
    touch ~/.cargo/config.toml
    echo -e '[registries.crates-io]\nprotocol = "sparse"\n[source.crates-io]\nreplace-with = "tuna-sparse"\n[source.tuna-sparse]\nregistry = "sparse+https://mirrors.tuna.tsinghua.edu.cn/crates.io-index/"' >>~/.cargo/config.toml

    # Print a success message
    echo -e "\033[1;32m******************* Cargo mirror set: TSINGHUA SPARSE ******************\033[0m"

    # Reload the shell configuration
    zsh -c "source ~/.zshrc"
fi
