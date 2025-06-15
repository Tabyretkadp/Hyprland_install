#!/bin/bash

set -e

echo "=== Проверка и установка yay ==="

if ! command -v yay &> /dev/null; then
    echo "yay не найден, устанавливаем..."
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    cd "$tmpdir/yay"
    makepkg -si --noconfirm
    cd -
    rm -rf "$tmpdir"
else
    echo "yay уже установлен"
fi

echo "=== Обновление системы ==="
yay -Syu --noconfirm

echo "=== Установка пакетов ==="

PACKAGES=(
    hyprland
    kitty
    waybar
    rofi
    swaylock
    neofetch
    nvim
    firefox
    telegram-desktop
)

yay -S --needed --noconfirm "${PACKAGES[@]}"

echo "=== Все пакеты установлены ==="
