set -U fish_greeting # disable fish greeting

# put homebrew on path
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
# https://github.com/Homebrew/brew/blob/main/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1
# disable interactive confirmation on upgrade/install prompts
set -Ux HOMEBREW_NO_ASK 1
fish_add_path /home/linuxbrew/.linuxbrew/bin

# set up development environment with mise
status --is-interactive; and mise activate fish | source
fish_add_path ~/.local/bin

# use helix as the default editor
set -x EDITOR hx

# use less to read manual pages (alternative: neovim)
set -gx MANPAGER less #nvim +Man!

# set bat's syntax highlighting theme
set -gx BAT_THEME "Catppuccin Macchiato"

# configure shell's prompt
set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source

# golang
fish_add_path /usr/local/go/bin
fish_add_path (go env GOPATH)/bin

abbr -a gg go get
abbr -a gb go build
abbr -a gi go install
abbr -a gor go run
abbr -a got go test ./...
abbr -a gmt go mod tidy

# rust/cargo
fish_add_path ~/.cargo/bin
# rust toolchain (auto-generated)
source "$HOME/.cargo/env.fish"

# helpful abbreviations
abbr -a ... "cd ../.."
abbr -a .... "cd ../../.."
abbr -a ..... "cd ../../../.."

abbr -a ll ls -lhiF
abbr -a la ls -alhiF
abbr -a lt ls -Alhrt
abbr -a rr rm -rf
abbr -a fd fd --hidden

abbr -a temp pushd (mktemp -d)
abbr -a serve python -m http.server
abbr -a rsv rsync -avh --info=progress2
abbr -a din dnf --cacheonly info
abbr -a dev cd ~/Documents

# nixos
abbr -a rebuild sudo nixos-rebuild switch
abbr -a collect sudo nix-collect-garbage -d

# replace ls with eza if available
command -q eza; and abbr -a ls eza -lh --group-directories-first
command -q eza; and abbr -a la eza -lah --group-directories-first

# automatically install fisher plugin manager
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

fzf --fish | source
export FZF_CTRL_T_OPTS="
    --style full
    --walker-skip .git,node_modules,target
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# opencode
fish_add_path /home/diego/.opencode/bin

# generate missing fish completions
if not test -f ~/.config/fish/completions/chezmoi.fish
    chezmoi completion fish --output=~/.config/fish/completions/chezmoi.fish
end

if not test -f ~/.config/fish/completions/mise.fish
    mise completion fish >~/.config/fish/completions/mise.fish
end

function mkcd -d "Create a new directory and change into it"
    mkdir -p $argv[1] && cd $argv[1]
end

function cdr -d "Change directory back to the root of the current repository"
    cd $(git rev-parse --path-format=relative --show-toplevel)
end

function syu -d "Update everything system-wide programs"
    sudo dnf upgrade
    # sudo rpm-ostree upgrade
    flatpak update -y
    brew update
    brew upgrade
    brew cleanup
    fisher update
    mise self-update -y
    mise upgrade
end

function gfs -d "List tracked Git files sorted by size"
    git ls-files -z | xargs -0 du -b | sort -n
end

# fish integration for direnv
# direnv hook fish | source
zoxide init --cmd cd fish | source
