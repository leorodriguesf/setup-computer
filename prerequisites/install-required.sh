#!/usr/bin/env sh

if [ "$(id -u)" -eq 0 ]; then
    SUDO=""

else
    SUDO="sudo"
fi

# Use sudo to install root privileges to prevent installation failures.
$SUDO echo "Installing required packages..."

apt-get update

export DEBIAN_FRONTEND=noninteractive

if ! command -v git >/dev/null; then
    apt-get install git -y
fi

if ! command -v python3 >/dev/null; then
    apt-get install python3 -y
fi

if ! command -v ansible >/dev/null; then
    apt install software-properties-common -y
    add-apt-repository --yes --update ppa:ansible/ansible
    apt install ansible -y
fi
