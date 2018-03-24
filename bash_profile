# Time-stamp: <Wed Feb 07 23:02:02 JST 2018>

# ~/.bashrcをターミナル起動時に読み込ませる
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# shの関数
source ~/.bash_script.bash

# gitの入力補完
source ~/.git-completion.bash

PS1="\n\h  ( \$(-pathWriter) )\
\$(-gitChecker)\
\n[ \t ] \$"


# 連続をしたコマンドを1度のみの記録に + スペースから始まるコマンドを無視
export HISTCONTROL=ignoreboth

# 履歴に保存しないコマンド
export HISTIGNORE=clear


# 履歴のサイズを変更
export HISTSIZE=30000

# Ctrl-dを1回無視する（2回で反応）
IGNOREEOF=1
export IGNOREEOF


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

# GOPATH
export GOPATH=$HOME/gopath_global
