# Time-stamp: <Sun Mar 25 14:08:57 JST 2018>
#!/bin/bash

if [ ${EUID:-${UID}} = 0 ]; then
    echo "ERROR"
    exit 1
fi

os=`uname 2>&1`
if [ ${os} = "Darwin" ]; then
    # macOS
    download_command='curl -# -o'
else
    # Linux ${os} = "Linux"
    download_command='wget -O'
fi

echo ""
echo -n "start update ~/.gitconfig?: y-or-n: "
read start
if [ $start = "y" ]; then

    echo -n "flush old gitconfig?: y-or-n: "
    read flushgitconfig
    if [ ${flushgitconfig} = "y" ]; then
        rm ~/.gitconfig > /dev/null 2>&1
    fi
    
    git config --global core.excludesfile ~/.gitignore_global
    git config --global core.editor emacs
    git config --global core.pager less
    git config --global color.ui true
    git config --global core.autocrlf input
    git config --global push.default nothing
    # git config --global push.default simple

    git config --global alias.co 'checkout'
    git config --global alias.st 'status'
    git config --global alias.br 'branch -v'
    git config --global alias.df 'diff'
    git config --global alias.cl 'clone'
    git config --global alias.clonea 'clone --recursive'
    git config --global alias.cla 'clone --recursive'
    git config --global alias.sub-clone 'submodule update --init --recursive'
    git config --global alias.wdiff 'diff --word-diff'

    echo ""
    echo "complete!!"

elif [ $start = "n" ]; then
    echo ""
    echo "PASS "
else
    echo ""
    echo "error"
fi

echo ""
echo "conf file: ~/.gitconfig"
echo ""
echo "Current user info..."
echo "user name: `cat ~/.gitconfig | grep "name = " | cut -b 2-`"
echo "user email: `cat ~/.gitconfig | grep "email = " | cut -b 2-`"
echo ""
echo "change or update"
echo "$ git config --global user.name '[username]'"
echo "$ git config --global user.email '[useremail]'"
echo ""
