# ${HOME}/.bash_profile 로 저장

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

export PS1="\[\e[36;1m\]\u@\[\e[32;1m\]\h:\[\e[31;1m\]\w:> \[\e[0m\]"

## 색 표시가 가능한 터미널로 설정. 
# 사용하는 터미널 에뮬레이터에서 제대로 표시되지 않는다면 linux대신 vt100이나 xterm 으로 변경한다.
export TERM=linux

## 한글 미지원 터미널일 경우 깨짐 방지
#export LC_MESSAGES=C

export VISUAL=/usr/bin/vim
alias vi='vim $*'
