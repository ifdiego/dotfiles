#!/bin/bash
set -euo pipefail

link() {
    mkdir -p "$(dirname "$2")"
    ln -i -s "$1" "$2"
}

packages=(
    base-devel
    btop
    direnv
    docker
    docker-compose
    duf
    fastfetch
    fd
    firefox
    fish
    flatpak
    fzf
    ghostty
    git
    github-cli
    gnome-boxes
    gnome-browser-connector
    go
    helix
    hyperfine
    jq
    man-db
    man-pages
    neovim
    nodejs
    noto-fonts
    npm
    ripgrep
    tmux
    tree
    wl-clipboard
    zellij
    zig
    zls
    zoxide
    zsh
)

sudo pacman -S --needed --noconfirm "${packages[@]}"

link "$(pwd)/.bash_profile" ~/.bash_profile
link "$(pwd)/.bashrc" ~/.bashrc
link "$(pwd)/.editorconfig" ~/.editorconfig
link "$(pwd)/.tmux.conf" ~/.tmux.conf
link "$(pwd)/.zshrc" ~/.zshrc

link "$(pwd)/.config/fish/config.fish" ~/.config/fish/config.fish
link "$(pwd)/.config/ghostty/config" ~/.config/ghostty/config
link "$(pwd)/.config/git/config" ~/.config/git/config
link "$(pwd)/.config/helix/config.toml" ~/.config/helix/config.toml
link "$(pwd)/.config/helix/languages.toml" ~/.config/helix/languages.toml
link "$(pwd)/.config/nvim/init.lua" ~/.config/nvim/init.lua
link "$(pwd)/.config/nvim/lazy-lock.json" ~/.config/nvim/lazy-lock.json
link "$(pwd)/.config/zellij/config.kdl" ~/.config/zellij/config.kdl

link "$(pwd)/.local/bin" ~/.local/bin
link "$(pwd)/.ssh/config" ~/.ssh/config

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://codeberg.org/ziglang/shell-completions $ZSH/custom/plugins/zig-shell-completions

go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/go-task/task/v3/cmd/task@latest
go install github.com/gohugoio/hugo@latest
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.10.1
go install github.com/goreleaser/goreleaser/v2@latest

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup default stable
source ~/.cargo/env
rustup component add clippy rust-analyzer

npm config set prefix '~/.local/'
npm install -g typescript typescript-language-server

flatpak install flathub com.brave.Browser
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.spotify.Client
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub org.qbittorrent.qBittorrent

curl -fsSL https://ampcode.com/install.sh | bash
curl -fsSL https://claude.ai/install.sh | bash
curl -fsSL https://opencode.ai/install | bash
