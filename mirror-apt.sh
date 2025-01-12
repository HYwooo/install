#!/bin/sh
# To learn if running in complicated network environment, and set apt mirror accordingly.
# From latest[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@latest/mirror-apt.sh | sh
# From master[raw]:
# curl -sSL https://raw.githubusercontent.com/HYwooo/install/refs/heads/master/mirror-apt.sh | sh
# From master[jsdelivr]:
# curl -sSL https://gcore.jsdelivr.net/gh/HYwooo/install@master/mirror-apt.sh | sh

# Install coreutils if not already installed
sudo apt install -y curl coreutils ca-certificates --quiet --no-install-recommends

if [ "$USE_MIRROR" != "1" ] && timeout 1 curl -s -o /dev/null https://www.google.com; then
    echo -e "\033[1;33mUSE_MIRROR not set to 1 and Google is reachable, skipping mirror setup.\033[0m"
    sudo sed -i 's/http:/https:/g' /etc/apt/sources.list.d/ubuntu.sources
else
    echo -e "\033[1;33mUSE_MIRROR set to 1 or Google is unreachable, setting up mirror.\033[0m"
    echo -e "\033[1;34m******************* Setting up apt mirror: TSINGHUA & USTC ******************\033[0m"

    # Replace HTTP with HTTPS
    sudo sed -i 's/http:/https:/g' /etc/apt/sources.list.d/ubuntu.sources

    # Replace with Tsinghua mirror
    sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.tuna.tsinghua.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources
    sudo sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/ubuntu.sources

    # Update package list and install necessary tools
    sudo apt update -y --fix-missing --quiet

    echo -e "\033[1;32m******************* apt mirror set: TSINGHUA & USTC ******************\033[0m"
fi
