#!/bin/zsh
sudo apt install -y coreutils ca-certificates gcc g++ rustup --quiet --no-install-recommends
if timeout 2 curl -s -o /dev/null https://www.google.com; then
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    /usr/bin/zsh -c "rustup default stable"
else
    echo -e "\033[1;31mTimeout: Unable to access Google.\033[0m"
    echo -e "\033[1;34m******************* Setting Rustup mirror: TSINGHUA   ******************\033[0m"
    
    /usr/bin/zsh -c "export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup"
    /usr/bin/zsh -c "export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup"
    echo "export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup" >>~/.zshrc
    echo "export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup" >>~/.zshrc
    /usr/bin/zsh -c "source ~/.zshrc"
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    echo -e "\033[1;32m******************* Rustup mirror set:    TSINGHUA    ******************\033[0m"
    /usr/bin/zsh -c "rustup default stable"
    mkdir -p $HOME/.cargo
    echo -e '[registries.crates-io]\nprotocol = "sparse"\n[source.crates-io]\nreplace-with = "tuna"\n[source.tuna]\nregistry = "sparse+https://mirrors.tuna.tsinghua.edu.cn/crates.io-index/"' >>~/.cargo/config.toml
    echo -e "\033[1;32m******************* Cargo mirror set: TSINGHUA SPARSE ******************\033[0m"
fi
