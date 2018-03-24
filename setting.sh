#!/bin/bash

if [ ${EUID:-${UID}} = 0 ]; then
    echo "ERROR"
	exit 1
fi

sudo echo "<<< start >>>"

if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrcOLD
fi

############
# download #
############
wget -O ~/.bashrc https://raw.githubusercontent.com/shogysd/settings/master/DOTbash_profile
wget -O ~/.bash_script.bash https://raw.githubusercontent.com/shogysd/settings/master/DOTbash_script.bash
wget -O ~/.emacs https://raw.githubusercontent.com/shogysd/settings/master/DOTemacs
wget -O ~/.gitignore_global https://raw.githubusercontent.com/shogysd/settings/master/DOTgitignore_global
wget -O ~/.git-completion.bash https://raw.githubusercontent.com/shogysd/git/master/contrib/completion/git-completion.bash
wget -O ~/gitconfigscript.sh https://raw.githubusercontent.com/shogysd/settings/master/gitconfigscript.sh
chmod 744 ~/gitconfigscript.sh
wget -O ~/ssh_config.sh https://raw.githubusercontent.com/shogysd/settings/master/ssh_config.sh
chmod 744 ~/ssh_config.sh

##################
# update/upgrade #
##################

sudo apt-get -y update
sudo apt-get -y upgrade


###########
# install #
###########

echo "--- install ---"
sudo apt-get -y install emacs
sudo apt-get -y install git
sudo apt-get -y install curl
sudo apt-get -y install python3
sudo apt-get -y install gcc
sudo apt-get -y install g++
sudo apt-get -y install clang
sudo apt-get -y install clang++
sudo apt-get -y install chromium
sudo apt-get -y install ibus-mozc
sudo apt-get -y install screen

# chrome関係
sudo apt-get -y install libcurl3
sudo apt-get -y install libappindicator1


#########
# SetUp #
#########

echo "--- setup ---"

dconf reset /org/gnome/settings-daemon/plugins/keyboard/active
# CapsLockキーとCtrlキーを入れ替える
# dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:swapcaps']"
# CapsLockキーを追加のCtrlキーとして使う場合
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
# CapsLockキーの動作をデフォルトに戻す場合
# dconf reset /org/gnome/desktop/input-sources/xkb-options

# ディレクトリのカタカナを英字表記に
sudo apt-get -y install xdg-user-dirs-gtk
LANG=C xdg-user-dirs-gtk-update

# gitの設定
~/gitconfigscript.sh
rm ~/gitconfigscript.sh

# sshの設定
~/ssh_config.sh
rm ~/ssh_config.sh

source ~/.bash_profile
echo "<<< finish >>>"
