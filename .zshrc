# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="crunch"
# ZSH_THEME="pure"
ZSH_THEME="dracula"

# Example aliases
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias zshrc="vim ~/.zshrc && reload"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias githash="git log --pretty=format:'%h' -n 1"
alias r="bundle exec rake"
alias v='vim'
alias bat='pmset -g batt'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# export PATH=/Users/andrewg/.rvm/gems/ruby-1.9.2-p290/bin:/Users/andrewg/.rvm/gems/ruby-1.9.2-p290@global/bin:/Users/andrewg/.rvm/rubies/ruby-1.9.2-p290/bin:/Users/andrewg/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
[[ -s "/Users/andrewg/.rvm/scripts/rvm" ]] && source "/Users/andrewg/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

PATH=$PATH:~/bin/subl

PATH=$PATH:~/dotfiles/scripts

set $EDITOR=vim

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/code
export PATH=$PATH:$GOPATH/bin

export NVM_DIR="/Users/andrewg/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
