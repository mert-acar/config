# If you come from bash you might have to change your $PATH.
source $HOME/.config/paths.zsh

export ZSH="$HOME/.oh-my-zsh"
export TERM="alacritty"
ZSH_THEME="robbyrussell"
plugins=(
  git 
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi


alias "cd"="z"
alias "vi"="nvim"
alias "lab"='jupyter lab'
alias "b"="black --line-length=100 *.py"

alias "ac"="conda activate"
alias "dc"="conda deactivate"

alias "gs"="git status"
alias "gc"="pre-commit-gen-message"
alias "gp"="git push"
alias "ga"="git add ."
alias "gg"="ga && gc && gp"

alias "ls"="eza --color=always --long --git --icons=always --no-user --no-permissions"
alias "ll"="ls -la"
alias "r"="ranger"
alias "rr"="rm -rf __pycache__"

alias "mython3"="PYTHONPATH=../src/ python3"
alias "mython"="PYTHONPATH=../src/ python"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Check if conda is initialized
if [[ -n "$CONDA_PREFIX" ]]; then
  conda activate "$(basename $CONDA_PREFIX)"
fi

# Set up fzf key bindings and fuzzy completion
eval "$(zoxide init zsh)"

source <(fzf --zsh)
fzf_vim_open() {
  local file
  file=$(fd --type f --hidden --exclude .git | fzf --preview 'bat --style=numbers --color=always {}')
  if [[ -n "$file" ]]; then
    vi "$file"
  fi
}
zle -N fzf_vim_open
bindkey '^S' fzf_vim_open
