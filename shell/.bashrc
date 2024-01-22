# --------------------------------- .BASHRC --------------------------------- #

# Do not use .bashrc if not running in interactive mode.
case $- in
    *i*) ;;
      *) return;;
esac


# ----------------------------- SOURCING FILES ------------------------------ #


# --------------------------------- ALIASES --------------------------------- #

alias ls='ls -AF1'
alias venv=". env/bin/activate"
alias newgitrepo="~/dotfiles/scripts/newgithubrepo.sh"

# aliases for nvim/vim/vi
alias vim="nvim"
alias vi="\vim"
alias v="\vi"


# --------------------------------- PROMPT ---------------------------------- #

# identify chroot (used in the prompt)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# format the prompt with chroot and color
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '


# ---------------------------- TERMINAL SETTINGS ---------------------------- #

# Allow colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

shopt -s checkwinsize       # Update window lines & columns if window size changed
shopt -s globstar           # ** for match all files and zero or more directories 

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"  # make `less` more friendly

# History Settings
HISTCONTROL=ignoreboth      # Disallow duplicates

shopt -s histappend         # append (not overwrite) to the history file

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000               # history length
HISTFILESIZE=2000

# Autocompletion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# pyenv

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

