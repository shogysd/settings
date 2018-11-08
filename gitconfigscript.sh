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

    echo ""
    echo "gitignore_global ->"
    ${download_command} ~/.gitignore_global https://raw.githubusercontent.com/shogysd/settings/master/config_files/gitignore_global

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
    git config --global alias.br 'branch -v'
    git config --global alias.df 'diff'
    git config --global alias.cl 'clone'
    git config --global alias.clonea 'clone --recursive'
    git config --global alias.cla 'clone --recursive'
    git config --global alias.sub-clone 'submodule update --init --recursive'
    git config --global alias.wdiff 'diff --word-diff'


    echo ""
    echo "When you execute the following command git's setup is completed!"
    echo ""
    echo "conf file: ~/.gitconfig"
    echo ""
    cat ~/.gitconfig | grep "name = "
    echo "change: $ git config --global user.name '[username]'"
    cat ~/.gitconfig | grep "email = "
    echo "change: $ git config --global user.email '[useremail]'"
    echo ""

elif [ $start = "n" ]; then
    echo "EXIT"
    echo ""
else
    echo "error"
    echo ""
fi
