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

# According to the zsh-completions README, this line should be before `source $ZSH/oh-my-zsh.sh`
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

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

# Set history file (for completeness) and history size
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# clear the screen
alias cl='clear'

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
# alias tmux-new='tmux new -s'
alias tnew='~/Scripts/tmux_new_session.sh'
alias tmux-kill='tmux kill-session -t'

# AWS VAULT ALIAS (ENVATO)
# alias aws='aws-vault exec enrique_mejias -- aws'
alias aws_with_profile='aws-vault exec $(cat ~/.aws/config | grep "profile" | sed -E "s/\[profile ([^]]*)\]/\1/" | fzf)'

# Fix colors for htop
alias htop='TERM=xterm-256color htop'

# Eza
alias ls='eza --icons'
alias ll='eza --icons -l'
alias eza='eza --icons'
alias ezal='eza --icons -l'
alias tree='eza --icons --tree'

# Firefox CLI
alias fx-cli='/Applications/Firefox.app/Contents/MacOS/firefox'

# New git branch in placeit repo
function new_pl_branch() {
    git checkout -b $1 $(git merge-base main staging1)
}

# ssh to staging 1
alias ssh-stg1='ssh -l deploy _staging.placeit.net'

# nvm
function load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
}

# rbenv
function load_rbenv() {
    eval "$(rbenv init -)"
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

# useful aliases for fzf
alias fzfscope="~/Scripts/fzfscope.sh"

# Cargo (Rust)
source "$HOME/.cargo/env"

# MySql
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/mysql@5.6/lib"
export CPPFLAGS="-I/usr/local/opt/mysql@5.6/include"
export DYLD_LIBRARY_PATH="/usr/local/opt/mysql@5.6/lib:$DYLD_LIBRARY_PATH"

# Make sure the curl executable is the one from brew
export PATH="/usr/local/opt/curl/bin:$PATH"

# Include /usr/local/sbin in PATH
export PATH="/usr/local/sbin:$PATH"

# opam configuration
[[ ! -r /Users/placeit/.opam/opam-init/init.zsh ]] || source /Users/placeit/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Zoxide
eval "$(zoxide init zsh)"

# Startship prompt
eval "$(starship init zsh)"

# Profiling ZSH end
# zprof
