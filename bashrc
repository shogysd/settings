# Time-stamp: <Wed Feb 07 23:02:02 JST 2018>

###############

# shの関数
source ~/.bash_script.bash

# gitの入力補完
source ~/.git-completion.bash

###############


PS1="\n\h  ( \$(-pathWriter) )\
\$(-gitChecker)\
\n[ \t ] \$"


# alias
alias python='python3'
alias py='python3'
alias grep='grep --color=auto'

# OS依存
os=`uname 2>&1`
if [ ${os} = "Darwin" ]; then
    # macOS
    alias ls='ls -G'
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
    alias sema='sudo /Applications/Emacs.app/Contents/MacOS/Emacs'
else
    # Linux ${os} = "Linux"
    alias sema='sudo emacs'
fi



# C++
alias clpp='clang++ -std=c++14'
alias clpp11='clang++ -std=c++11'
alias clpp14='clang++ -std=c++14'
alias gpp='g++ -std=c++14'
alias gpp11='g++ -std=c++11'
alias gpp14='g++ -std=c++14'

# GOPATH
export GOPATH=$HOME/gopath_global
