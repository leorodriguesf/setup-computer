#!/usr/bin/env sh

if [ "$(id -u)" -eq 0 ]; then
    alias sudo=""
fi

# Use sudo to install root privileges to prevent installation failures.
sudo echo "Installing required packages..."

sudo apt-get update

export DEBIAN_FRONTEND=noninteractive

if ! command -v git >/dev/null; then
    sudo apt-get install git -y
fi

if ! command -v python3 >/dev/null; then
    sudo apt-get install python3 -y
fi

if ! command -v ansible >/dev/null; then
    sudo apt install software-properties-common -y
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible -y
fi
