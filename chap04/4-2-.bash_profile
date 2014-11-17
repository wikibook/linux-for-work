# ${HOME}/.bash_profile 로 저장

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

export PS1="\[\e[36;1m\]\u@\[\e[32;1m\]\h:\[\e[31;1m\]\w:> \[\e[0m\]"
export TERM=linux
## 한글 미지원 터미널일 경우 깨짐 방지
#export LC_MESSAGES=C

export VISUAL=/usr/bin/vim
alias vi='vim $*'
