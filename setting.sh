#!/bin/bash

if [ ${EUID:-${UID}} = 0 ]; then
    echo "ERROR"
	exit 1
fi

sudo echo "<<< start >>>"

if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrcOLD
fi

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

# unity-settings-daemon/gnome-settings-daemon のプラグインを有効にする
dconf reset /org/gnome/settings-daemon/plugins/keyboard/active

# CapsLockキーとCtrlキーを入れ替える
# dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:swapcaps']"

# CapsLockキーを追加のCtrlキーとして使う
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"

# CapsLockキーの動作をデフォルトに戻す場合
# dconf reset /org/gnome/desktop/input-sources/xkb-options


# ディレクトリのカタカナを英字表記に
sudo apt-get -y install xdg-user-dirs-gtk
LANG=C xdg-user-dirs-gtk-update

echo "<<< finish >>>"
