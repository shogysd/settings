#!/bin/bash

if [ ${EUID:-${UID}} != 0 ]; then
    echo "ERROR"
	exit 1
fi

apt-get -y install emacs
update-alternatives --config editor

apt-get -y install sudo
visudo

apt-get -y install curl

apt-get -y install xdg-user-dirs-gtk
LANG=C xdg-user-dirs-gtk-update
