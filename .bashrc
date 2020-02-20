# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

prompt_git() {
  local s=""
  local branchName=""
  
  # check if the current directory is in a git repository
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; printf "%s" $?) == 0 ]; then
    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == "false" ]; then
      # ensure index is up to date
      git update-index --really-refresh  -q &>/dev/null
      # check for uncommitted changes in the index
      if ! $(git diff --quiet --ignore-submodules --cached); then
        s="$s+";
      fi
      # check for unstaged changes
      if ! $(git diff-files --quiet --ignore-submodules --); then
        s="$s!";
      fi
      # check for untracked files
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        s="$s?";
      fi
      # check for stashed files
      if $(git rev-parse --verify refs/stash &>/dev/null); then
        s="$s$";
      fi
    fi
    
    # get the short symbolic ref
    # if HEAD isn't a symbolic ref, get the short SHA
    # otherwise, just give up
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
      git rev-parse --short HEAD 2> /dev/null || \
      printf "(unknown)")"
    
    [ -n "$s" ] && s=" [$s]"
    printf "%s" "$1$branchName$s"
  else
    return
  fi
}

# Highlight the user name when logged in as root.
#if [[ "${USER}" == "root" ]]; then
#	user="${blue}";
#else
#	user="${cyan}";
#fi;

# Highlight the hostname when connected via SSH.
#if [[ "${SSH_TTY}" ]]; then
#	host="${violet}";
#else
#	host="${green}";
#fi;

PS1="\[\033[1;32m\]\u\[\033[00m\] at \[\033[1;36m\]\h\[\033[00m\] in \[\033[1;34m\]\W\$(prompt_git \"\[\033[00m\] on \[\033[1;31m\]\")\n\[\033[00m\]\$ \[\033[0m\]";
