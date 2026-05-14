#!/usr/bin/env bash
set -euo pipefail

. /etc/os-release
curl -fsSL "https://copr.fedorainfracloud.org/coprs/scottames/ghostty/repo/fedora-${VERSION_ID}/scottames-ghostty-fedora-${VERSION_ID}.repo" | sudo tee /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:scottames:ghostty.repo > /dev/null
rpm-ostree refresh-md && rpm-ostree install ghostty

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install fd
brew install fish
brew install fzf
brew install gh
brew install go
brew install gopls
brew install helix
brew install hugo
brew install neovim
brew install ripgrep
brew install starship
brew install tmux
brew install zellij
brew install zoxide
brew install zsh

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.brave.Browser
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub md.obsidian.Obsidian
flatpak install -y flathub de.haeckerfelix.Fragments
flatpak install -y flathub org.videolan.VLC

mv ~/id_ed25519 ~/.ssh # it assumes ssh key was copied from a pendrive to home folder
chmod 600 ~/.ssh/id_ed25519
curl https://github.com/ifdiego.keys -o ~/.ssh/id_ed25519.pub
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.com

gh auth login

gsettings set org.gnome.desktop.peripherals.keyboard delay 200
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 10

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://codeberg.org/ziglang/shell-completions $ZSH/custom/plugins/zig-shell-completions

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
rustup component add clippy rust-analyzer

curl -fsSL https://opencode.ai/install | bash
