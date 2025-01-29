#!/bin/sh

# Install Rust and set up environment variables using a mirror (RsProxy.cn)
# This script is intended for environments where access to Google is restricted.
################################################################################
# Usage:
# From latest[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@latest/install-rust.sh | sh
# From master[raw]:
# curl -sSL https://raw.githubusercontent.com/HYwooo/install/refs/heads/master/install-rust.sh | sh
# From master[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/install-rust.sh | sh
################################################################################

# Install build dependencies quietly without recommended packages
sudo apt install -y coreutils ca-certificates gcc g++ --quiet --no-install-recommends

# Set Rustup mirror environment variables
echo -e "\033[134m******************* Setting Rustup mirror: RsProxy.cn ******************\033[0m"

# Export environment variables for current session and persist in .bashrc
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# Append variables to .bashrc (ensure proper exports)
echo 'export RUSTUP_DIST_SERVER="https://rsproxy.cn"' >> ~/.bashrc
echo 'export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"' >> ~/.bashrc  

# Ensure .bashrc exists and reload environment
touch ~/.bashrc

# Install Rust using the mirror
curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh -s -- -y

# Add Cargo's bin directory to PATH
echo '. "$HOME/.cargo/env"' >> ~/.bashrc  # Persist for future sessions


echo -e "\033[1;32m******************* Rustup mirror set:    RsProxy.cn    ******************\033[0m"

# Configure Cargo to use sparse registry mirror
mkdir -p ~/.cargo  # Ensure directory exists
touch ~/.cargo/config.toml  # Ensure file exists
cat > ~/.cargo/config.toml << EOF
[source.crates-io]
replace-with = "rsproxy-sparse"

[source.rsproxy]
registry = "https://rsproxy.cn/crates.io-index"

[source.rsproxy-sparse]
registry = "sparse+https://rsproxy.cn/index/"

[registries.rsproxy]
index = "https://rsproxy.cn/crates.io-index"

[net]
git-fetch-with-cli = true
EOF

echo -e "\033[1;32m******************* Cargo mirror set: RsProxy.cn SPARSE ******************\033[0m"

# Final environment reload
. ~/.bashrc