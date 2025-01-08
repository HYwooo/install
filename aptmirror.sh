#!/bin/sh

# curl -sSL https://raw.githubusercontent.com/HYwooo/install/master/aptmirror.sh | sh
# Install coreutils if not already installed
sudo apt install -y coreutils ca-certificates

# Try to access Google with a timeout of 2 seconds
if timeout 2 curl -s -o /dev/null https://www.google.com; then

    sed -i 's/http:/https:/g' /etc/apt/sources.list.d/ubuntu.sources
else
    # If timeout, execute action A
    echo -e "\033[1;31mTimeout: Unable to access Google, executing action A\033[0m"
    echo -e "\033[1;34m******************* Setting apt mirror: TSINGHUA & USTC ******************\033[0m"
    
    # Replace HTTP with HTTPS
    sed -i 's/http:/https:/g' /etc/apt/sources.list.d/ubuntu.sources
    # Replace with Tsinghua mirror
    sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.tuna.tsinghua.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources
    sudo sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/ubuntu.sources

    # Update package list and install necessary tools
    sudo apt update -y --fix-missing

    echo -e "\033[1;32m******************* apt mirror set: TSINGHUA & USTC ******************\033[0m"
fi
