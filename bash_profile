# Time-stamp: <Thu May 31 21:48:09 JST 2018>

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
\n[ \t\$(-envWriter) ] \$"


# 連続をしたコマンドを1度のみの記録に + スペースから始まるコマンドを無視
export HISTCONTROL=ignoreboth

# 履歴に保存しないコマンド
export HISTIGNORE=clear


# 履歴のサイズを変更
export HISTSIZE=30000

# 履歴のフォーマットを設定
export HISTTIMEFORMAT='%Y-%m-%d %T   '

# Ctrl-dを1回無視する（2回で反応）
IGNOREEOF=1
export IGNOREEOF

# virtualenvでpromptを変更しない
export VIRTUAL_ENV_DISABLE_PROMPT=1


alias rm='rm -i'

# OS依存
os=`uname 2>&1`
if [ ${os} = "Darwin" ]; then
    # macOS
    alias ls='ls -G'
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
    alias sema='sudo /Applications/Emacs.app/Contents/MacOS/Emacs'
    bin_path=`echo /Library/Frameworks/Python.framework/Versions/3.[0-9]/bin`
    export PATH="${bin_path}:${PATH}"
else
    # Linux ${os} = "Linux"
    alias sema='sudo emacs'
fi

# GOPATH
export GOPATH=$HOME/gopath_global
