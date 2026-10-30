if status is-interactive
    # Commands to run in interactive sessions can go here
end

# variables
set -gx VISUAL hx
set -gx EDITOR hx
set -gx MANPAGER less #nvim +Man!
set -gx BAT_THEME "Catppuccin Macchiato"
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_NO_ASK 1
set -gx STARSHIP_CONFIG ~/.config/starship.toml
set -gx PNPM_HOME /home/diego/.local/share/pnpm

# path
fish_add_path ~/.local/bin
fish_add_path /home/linuxbrew/.linuxbrew/bin
fish_add_path (go env GOPATH)/bin
fish_add_path ~/.cargo/bin
fish_add_path /home/diego/.opencode/bin
fish_add_path /home/diego/.local/share/pnpm/bin

# abbreviations
abbr -a pn pnpm
abbr -a lg lazygit
abbr -a oc opencode
abbr -a rr rm -rf
abbr -a fd fd --hidden
abbr -a mu mise upgrade

abbr -a dev cd ~/Documents
abbr -a gmt go mod tidy
abbr -a cdr "cd (git rev-parse --show-toplevel)"
abbr -a glf "git ls-files -z | xargs -0 -r du -b -- | sort -n"

# tools
# direnv hook fish | source
mise activate fish | source
starship init fish | source
zoxide init --cmd cd fish | source
