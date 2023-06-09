# zmodload zsh/zprof
# Profiling ZSH begin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ZSH_THEME=robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  git
  vi-mode
  zsh-completions
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Completions
autoload -U compinit && compinit

# colors
autoload colors zsh/terminfo
colors

# Run cd automatically when a path is typed
setopt auto_cd

# if you do a 'rm *', Zsh will give you a sanity check!
setopt RM_STAR_WAIT

# allows you to type Bash style comments on your command line
# good 'ol Bash# setopt interactivecomments
setopt interactivecomments

# Zsh has a spelling corrector
setopt CORRECT

# Reduce delay on <Esc> key press to change vi modes
export KEYTIMEOUT=1

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# Prompt when overwriting existing files
alias mv='mv -i'

alias vim=/usr/local/bin/nvim
alias vimdiff="/usr/local/bin/nvim -d"

# Make sure that if a program wants you to edit
# text, that Vim is going to be there for you
export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

# BAT
export BAT_THEME="gruvbox-dark"

# User BAT as man pager
export MANPAGER='col -bx | bat -l man -p'

# aliases for Tmux
alias tmux='tmux -2'
alias tmux-attach='tmux attach -t'
alias tmux-new='tmux new -s'
alias tmux-kill='tmux kill-session -t'

# AWS VAULT ALIAS (ENVATO)
alias aws='aws-vault exec enrique_mejias -- aws'

# Fix colors for htop
alias htop='TERM=xterm-256color htop'

# Exa
alias ls='exa --icons'
alias ll='exa --icons -l'
alias exa='exa --icons'
alias exal='exa --icons -l'

# nvm
load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
}

# rbenv
load_rbenv() {
    eval "$(rbenv init -)"
}

# Detach, if inside tmux, or exit
exit() {
    if [[ $RANGER_LEVEL -gt 0 ]] || [[ -z $TMUX ]]; then
        builtin exit
    else
        count_tmux_windows=`tmux lsw | wc -l`
        if [[ $count_tmux_windows -gt 1 ]]; then
            builtin exit
        else
            count_window_panes=`tmux lsp | wc -l`
            if [[ $count_window_panes -gt 1 ]]; then
                builtin exit
            else
                tmux detach
            fi
        fi
    fi
}

export PATH="/Users/placeit/Projects/Envato/deploy/bin:$PATH"
# switch API
export PATH="/Users/placeit/Projects/Envato/switch/bin:$PATH"

# TMUX
if [[ $RANGER_LEVEL -eq 0 ]]; then
    if which tmux >/dev/null 2>&1; then
        #if not inside a tmux session, and if no session is started, start a new session
        test -z "$TMUX" && (tmux attach || tmux new-session)
    fi
fi

# FZF Config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --follow --hidden --smart-case --glob "!.git/*"'

# Cargo (Rust)
source "$HOME/.cargo/env"

# MySql
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/mysql@5.6/lib"
export CPPFLAGS="-I/usr/local/opt/mysql@5.6/include"
export DYLD_LIBRARY_PATH="/usr/local/opt/mysql@5.6/lib:$DYLD_LIBRARY_PATH"

# Zoxide
eval "$(zoxide init zsh)"

# Startship prompt
eval "$(starship init zsh)"
