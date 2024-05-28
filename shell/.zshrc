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
eval "$(pyenv virtualenv-init -)"


# --------------------------------- ALIASES --------------------------------- #

alias ls="ls -AF1"

alias newgitrepo="/Users/forrest/dotfiles/scripts/newgithubrepo.sh"
alias venv=". env/bin/activate"

alias dark="python3 /Users/forrest/dotfiles/scripts/colorchange.py" 
alias light="python3 /Users/forrest/dotfiles/scripts/colorchange.py" 

alias readingnotes="python3 /Users/forrest/dotfiles/scripts/readingnotes.py"
alias slk="python3 /Users/forrest/dotfiles/scripts/selkirknotes.py"
alias note="python3 /Users/forrest/dotfiles/scripts/notes.py"
alias notes="cd ~/Documents/notes"

alias desktop="cd ~/Desktop"
alias config="cd ~/.config"
alias dotfiles="cd ~/dotfiles"

# needed for using in local envs without installing everytime
alias llm='/Users/forrest/.pyenv/versions/3.12.1/bin/llm'


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

# set terminal colors with gruvbox themes
source /Users/forrest/.local/share/nvim/site/pack/paqs/start/gruvbox/gruvbox_256palette.sh

export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
