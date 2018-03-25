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
echo "update file: .gitconfig"
echo -n "start update?: y-or-n: "
read start
if [ $start = "y" ]; then

    echo -n "gitignore_global ->"
    ${download_command} ~/.gitignore_global https://raw.githubusercontent.com/shogysd/settings/master/gitignore_global 2>&1 | awk -F ' ' '{print $2}'

    rm ~/.gitconfig > /dev/null 2>&1

    git config --global core.excludesfile ~/.gitignore_global
    git config --global core.editor emacs
    git config --global core.pager less
    git config --global color.ui true
    git config --global core.autocrlf input
    git config --global push.default nothing
    # git config --global push.default simple


    git config --global alias.co 'checkout'
    git config --global alias.st 'status'
    git config --global alias.br 'branch'
    git config --global alias.df 'diff'
    git config --global alias.clonea 'clone --recursive'
    git config --global alias.sub-clone 'submodule update --init --recursive'
    git config --global alias.wdiff 'diff --word-diff'
    git config --global alias.ignore-switch \!~/.gitignore-switch.bash


    echo ""
    echo "When you execute the following command git's setup is completed!"
    echo "git config --global user.name '[username]'"
    echo "git config --global user.email '[useremail]'"
    echo ""

elif [ $start = "n" ]; then
    echo "EXIT"
else
    echo "error"
fi
