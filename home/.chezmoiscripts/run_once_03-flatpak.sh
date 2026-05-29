#!/usr/bin/env bash
set -eu

echo ""
echo "--- Installing/updating flatpaks ---"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.brave.Browser
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub md.obsidian.Obsidian
flatpak install -y flathub de.haeckerfelix.Fragments
flatpak install -y flathub org.videolan.VLC
