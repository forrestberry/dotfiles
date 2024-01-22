# --------------------------------- .ZSHRC ---------------------------------- #


# ----------------------------- SOURCING FILES ------------------------------ #

source ~/dotfiles/shell/.fzf.zsh        # fzf

# add homebrew to path
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# add pyenv to path
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# --------------------------------- ALIASES --------------------------------- #

alias ls="ls -AF1"

alias newgitrepo="/Users/forrest/dotfiles/scripts/newgithubrepo.sh"
alias venv=". env/bin/activate"

alias dark="python3 /Users/forrest/dotfiles/alacritty/colorchange.py" 
alias light="python3 /Users/forrest/dotfiles/alacritty/colorchange.py" 

alias readingnotes="python3 /Users/forrest/dotfiles/scripts/readingnotes.py"
alias slk="python3 /Users/forrest/dotfiles/scripts/selkirknotes.py"
alias note="python3 /Users/forrest/dotfiles/scripts/notes.py"
alias notes="cd ~/Documents/notes"

alias desktop="cd ~/Desktop"
alias config="cd ~/.config"
alias dotfiles="cd ~/dotfiles"

# aliases for nvim/vim/vi
alias vim="nvim"
alias vi="\vim"
alias v="\vi"

# aliases for md5 to act like md5sum
# https://raamdev.com/2008/howto-install-md5sum-sha1sum-on-mac-os-x/
alias md5sum='md5 -r'


# --------------------------------- PROMPT ---------------------------------- #

# Format the prompt with color
PS1='%F{green}%n@%m%f:%F{blue}%~%f '

# spell check
setopt correct
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[blue]%r$reset_color? [yes, no, abort, edit] "


# ---------------------------- TERMINAL SETTINGS ---------------------------- #


