# If you come from bash you might have to change your $PATH.
source $HOME/.config/paths.zsh

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
  1password
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

alias "vi"="nvim"
alias "tmux"="tmux -u"
alias "lab"='jupyter lab'
alias "b"="black --line-length=100 *.py"

alias "ac"="conda activate"
alias "dc"="conda deactivate"

alias "gs"="git status"
alias "gc"="pre-commit-gen-message"
alias "gp"="git push"
alias "ga"="git add ."
alias "gg"="ga && gc && gp"

alias "r"="ranger"
alias "ll"="ls -la"
alias "rr"="rm -rf __pycache__"

alias "mython3"="PYTHONPATH=../src/ python3"
alias "mython"="PYTHONPATH=../src/ python"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($HOME/miniconda3/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<#

# Check if conda is initialized
if [[ -n "$CONDA_PREFIX" ]]; then
  conda activate "$(basename $CONDA_PREFIX)"
fi
