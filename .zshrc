export ZSH="/Users/d.andronov/.oh-my-zsh"

ZSH_THEME="alanpeabody"

plugins=(git fasd)

source $ZSH/oh-my-zsh.sh

# User configuration

# transferer for t.bk.ru
transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://t.bk.ru/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://t.bk.ru/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://t.bk.ru/$file_name"|tee /dev/null;fi;}

export CDPATH=$HOME
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

can-exec() {
  which "$1" 2>/dev/null 1>/dev/null
}

if uname -a | grep Darwin > /dev/null; then
  export IS_MACOS=1
else
  export IS_MACOS=0
fi

# history
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=2500
export SAVEHIST=$HISTSIZE
## add timestamps to history
setopt EXTENDED_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
## adds history
setopt APPEND_HISTORY
## adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
## don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST

# colors
export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true

# keybinds
WORDCHARS='*[]~;!#$%^(){}<>'
## shift-tab
bindkey '^[[Z' reverse-menu-complete
## ctrl-w
bindkey '^W' backward-kill-word
## ctrl-a, ctrl-e
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
## alt-b, alt-f
bindkey '\eb' backward-word
bindkey '\ef' forward-word
## ctrl-u
bindkey '^U' backward-kill-line
## history
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^R' history-incremental-search-backward

# aliases
## general
alias ll="ls -lh"
alias la="ls -a"
alias lla="ls -lah"

alias lcd="cd \$(pwd -P)"

mkcd() {
  mkdir -p "$@"
  cd "$@"
}

new-tmp() {
  mkcd "$HOME/m/oneoff-code/$(date '+%Y-%m-%d')"
}

alias grep="grep --color=auto"

alias rm="rm -f"
alias cp="cp -f"
alias mv="mv -f"

alias _="sudo"
alias suz="su -m -c zsh"
alias sudz="sudo ZDOTDIR=\$HOME PATH=\$PATH zsh"


gfcd() {
  local repo=$1
  git clone "$repo"
  local repo=${repo##*/}
  local repo=${repo%.git}
  cd "$repo"
}


## zsh
alias edit-zsh="vim ~/.my.zshrc; source ~/.zshrc"
alias edit-zshrc="vim ~/.zshrc; source ~/.zshrc"
alias time-zsh="time zsh -i -c exit"

## ssh
alias copy-ssh="cat ~/.ssh/id_rsa.pub | pbcopy"
alias edit-ssh="vim ~/.ssh/config"
alias show-ssh="cat ~/.ssh/config"


## git
alias gcwip="git add -A && git commit -m 'wip'"
alias gcfix="git add -A && git commit -m 'fix'"
alias gckik="git add -A && git commit -m 'kik'"
alias gcpkik="git add -A && git commit -m 'kik' && git push origin dev"

alias gcu="git add -A && git commit --amend --reuse-message HEAD"

## python
alias p2="python2"
alias p3="python3"
alias pp2="python2 -m ptpython"
alias pp3="python3 -m ptpython"

## network
if [[ $IS_MACOS -eq 1 ]]; then
  alias show-ports="lsof -iTCP -sTCP:LISTEN -n -P"
else
  alias show-ports="netstat -tulpn"
fi

alias edit-hosts="vim /etc/hosts"
alias show-hosts="cat /etc/hosts"


## util
random-string() {
  openssl rand -hex "$1"
}

timestamp() {
  date +%s
}

extip() {
  curl ifconfig.co
}

## working dirs

# c dir
updc() {
  cd $HOME/imagine
  git pull
  git status
}

# go dir
updgo() {
  cd $HOME/go/mailru/goimagine
  git pull
  git status
}

# puppet dir
updpup() {
  cd $HOME/mapuppet
  git pull
  git status
}

# k8s dir
updk8s() {
  cd $HOME/mail-antispam-k8s
  git pull
  git status
}
