# brew shell completion
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi


# PATH
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export LC_ALL=en_US.UTF-8

export HOMEBREW_NO_INSTALL_CLEANUP=true

export PATH="$HOME/bin:$PATH"

export PATH="$HOME/Maven/bin:$PATH"

eval "$(fzf --zsh)"

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" 

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


# alias
alias pn="pnpm"

alias pip="pip3"


# Iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# Zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Zinit plugins
zinit light zsh-users/zsh-autosuggestions

zinit light zdharma-continuum/fast-syntax-highlighting
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit load agkozak/zsh-z

zinit snippet OMZP::sudo 

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# omz
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

source $ZSH/oh-my-zsh.sh


# conda initialize
__conda_setup="$('/Users/kele/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kele/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/kele/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kele/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
