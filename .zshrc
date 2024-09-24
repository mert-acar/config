# If you come from bash you might have to change your $PATH.
export PATH=/usr/bin:$HOME/bin:/usr/local/bin:$PATH

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
alias "r"="ranger"
alias "ac"="conda activate"
alias "dc"="conda deactivate"
alias "ll"="ls -la"
alias "rr"="rm -rf __pycache__"
alias "lab"='jupyter lab'
alias "b"="black --line-length=100 *.py"

export PATH=$PATH:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$PATH:/Users/smol/Library/Python/3.9/bin
# export NVIM_TUI_ENABLE_TRUE_COLOR=1

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/smol/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/smol/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/smol/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/smol/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
# Check if conda is initialized
if [[ -n "$CONDA_PREFIX" ]]; then
  conda activate "$(basename $CONDA_PREFIX)"
fi
