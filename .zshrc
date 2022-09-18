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
  # cp
  git
  # npm
  # pip
  vi-mode
  z
  zsh-completions
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# fix dircolors
# eval $(dircolors ~/.dircolors)

source $ZSH/oh-my-zsh.sh

. $ZSH/plugins/z/z.sh

# Completions
autoload -U compinit && compinit

# colors
autoload colors zsh/terminfo
colors

# want your terminal to support 256 color schemes? I do ...
# export TERM="xterm-256color"
# export TERM="rxvt-unicode-256color"
# export TERMINAL="rxvt-unicode-256color"

# Run cd automatically when a path is typed
setopt auto_cd

# if you do a 'rm *', Zsh will give you a sanity check!
setopt RM_STAR_WAIT

# allows you to type Bash style comments on your command line
# good 'ol Bash# setopt interactivecomments
setopt interactivecomments

# Zsh has a spelling corrector
setopt CORRECT

# Make sure that if a program wants you to edit
# text, that Vim is going to be there for you
export EDITOR="vim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

# Reduce delay on <Esc> key press to change vi modes
export KEYTIMEOUT=1

# fzf config
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --follow --hidden --smart-case --glob "!.git/*"'
# export FZF_DEFAULT_OPTS='--preview="bat {+} --color always"'

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# Prompt when overwriting existing files
alias mv='mv -i'

# alias vim=/usr/local/bin/vim
alias vim=/usr/local/bin/nvim

# BAT
export BAT_THEME="gruvbox-dark"

# ooh, what is this? Aliases?
# source $ZSH/.oh-my-zsh/lib/alias.zsh

# aliases for Tmux
alias tmux='tmux -2'
alias tmux-attach='tmux attach -t'
alias tmux-new='tmux new -s'
alias tmux-kill='tmux kill-session -t'

# HIDE ME ALIAS
alias hide-start='sudo ipsec start'
alias hide-up='sudo ipsec up hide-nl'
alias hide-down='sudo ipsec down hide-nl'
alias hideme='~/Apps/hideme-connect.sh '

# AWS VAULT ALIAS (ENVATO)
alias aws='aws-vault exec enrique_mejias -- aws'

# nvm
load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
}

# rvm
load_rvm() {
    source /Users/placeit/.rvm/scripts/rvm
}

alias compass='/usr/bin/compass.ruby2.1'
alias shk='python2 ~/Apps/shakespeare/usr/lib/shakespeare/shk.py'

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

# export PATH="/home/kiyov/.gem/ruby/2.5.0/bin:$PATH"
export PATH="/Users/placeit/Projects/Envato/deploy/bin:$PATH"

# switch API
export PATH="/Users/placeit/Projects/Envato/switch/bin:$PATH"

# Anaconda
# export PATH="/usr/local/anaconda3/bin:$PATH"  # commented out by conda initialize

# TMUX
if [[ $RANGER_LEVEL -eq 0 ]]; then
    if which tmux >/dev/null 2>&1; then
        #if not inside a tmux session, and if no session is started, start a new session
        test -z "$TMUX" && (tmux attach || tmux new-session)
    fi
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/kiyov/.nvm/versions/node/v8.11.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/kiyov/.nvm/versions/node/v8.11.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/kiyov/.nvm/versions/node/v8.11.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /home/kiyov/.nvm/versions/node/v8.11.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# MySql
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/mysql@5.6/lib"
export CPPFLAGS="-I/usr/local/opt/mysql@5.6/include"
export DYLD_LIBRARY_PATH="/usr/local/opt/mysql@5.6/lib:$DYLD_LIBRARY_PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

# __conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/usr/local/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/usr/local/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup

# <<< conda initialize <<<

# Profiling ZSH end
# zprof




#
# THIS IS THE DEFAULT ZSH CONFIG
#
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#export ZSH="/Users/placeit/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
