#! /usr/bin/env bash

if [[ -f /usr/sbin/pacman ]]; then
    sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
elif [[ -f /usr/sbin/apt ]]; then
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install make gcc ripgrep unzip git xclip neovim
elif [[ -f /usr/sbin/dnf ]]; then
    sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
fi
