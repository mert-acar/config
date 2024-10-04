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

alias "cd"="z"
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

alias "ls"="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias "ll"="ls -la"
alias "r"="ranger"
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

eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --no-ignore --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --no-ignore --exclude .git"

_fzf_compgen_path() {
  fd --hidden --no-ignore --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --no-ignore --exclude .git . "$1"
}

fzf_vim_open() {
  # Use fzf to fuzzy find the file and then open it with vim
  local file
  file=$(fd --hidden --no-ignore --exclude .git | fzf --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {}')

  # If a file is selected, open it in vim
  if [[ -n "$file" ]]; then
    vi "$file"
  fi
}

zle -N fzf_vim_open

# Bind Control-S to fuzzy find files and open with vim
bindkey '^S' fzf_vim_open

export BAT_THEME="Monokai Extended Origin"


show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

eval $(thefuck --alias)
eval $(thefuck --alias fk)

eval "$(zoxide init zsh)"
