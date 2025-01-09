#!/bin/sh
# TO learn if running in compicated network environment, and set apt mirror accordingly.
# curl -sSL https://raw.githubusercontent.com/HYwooo/install/master/mirror-apt.sh | sudo sh
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/mirror-apt.sh | sudo sh
# Install coreutils if not already installed
sudo apt install -y coreutils ca-certificates --quiet --no-install-recommends
# Try to access Google with a timeout of 2 seconds
if [ -z "$USE_APT_MIRROR" ] && timeout 2 curl -s -o /dev/null https://www.google.com; then
    sed -i 's/http:/https:/g' /etc/apt/sources.list.d/ubuntu.sources
else
    # If timeout:
    echo -e "\033[1;31mTimeout: Unable to access Google.\033[0m"
    echo -e "\033[1;34m******************* Setting apt mirror: TSINGHUA & USTC ******************\033[0m"
    
    # Replace HTTP with HTTPS
    sed -i 's/http:/https:/g' /etc/apt/sources.list.d/ubuntu.sources

    # Replace with Tsinghua mirror
    sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.tuna.tsinghua.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources
    sudo sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/ubuntu.sources

    # Update package list and install necessary tools
    sudo apt update -y --fix-missing --quiet

    echo -e "\033[1;32m******************* apt mirror set: TSINGHUA & USTC ******************\033[0m"
fi
