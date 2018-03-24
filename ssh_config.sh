#!/bin/bash

os=`uname 2>&1`

ls ~/.ssh/config &> /dev/null
if [ $? = 0 ]; then

    echo "~/.ssh/config is exists!!"
    cat ~/.ssh/config
    echo ""
    echo "~/.ssh/config will be overwritten!!"
    echo -n "continue? : y-or-n: "
    read start

    if [ $start != "y" ]; then
        exit -1
    fi
fi

echo "Host *" > ~/.ssh/config
echo -e "\tForwardAgent yes" >> ~/.ssh/config

if [ ${os} = "Darwin" ]; then
    # macOS
    echo -e "\tAddKeysToAgent yes" >> ~/.ssh/config
    echo -e "\tUseKeychain yes" >> ~/.ssh/config
    # else
    # Linux ${os} = "Linux"
fi
