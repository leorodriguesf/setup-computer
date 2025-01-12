#!/usr/bin/env sh

# Exit immediately if a command exits with a non-zero status
set -e

detect_platform() {
    local platform
    platform="$(uname -s | tr '[:upper:]' '[:lower:]')"

    case "${platform}" in
    darwin) platform="macos" ;;
    esac

    printf '%s' "${platform}"
}

platform="$(detect_platform)"

if [ "${platform}" = "linux" ]; then
    if [ ! -f /etc/os-release ]; then
        echo "$(tput setaf 1)Error: Unable to determine OS. /etc/os-release file not found."
        echo "Installation stopped."
        exit 1
    fi

    . /etc/os-release

    platform="$ID"
fi

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export SETUP_HOME="$XDG_DATA_HOME/setup-computer"

cd ~
rm -rf "$SETUP_HOME"
git clone https://github.com/leorodriguesf/setup-computer.git --branch="$platform" "$SETUP_HOME"
cd - >/dev/null

cd $SETUP_HOME

echo "Installation starting..."

./install
