# Debianの初期設定

## rootユーザーでの作業
( suしておく )

### emacsをインストールする
```
# apt-get -y install emacs
```

### 標準のエディタを確認・変更する
```
# update-alternatives --config editor
```

### sudoを打てるようにする
```
# apt-get install sudo
# visudo
→ rootと同じ内容を記述
```

### ディレクトリを英語表記にする
```
$ sudo apt-get install xdg-user-dirs-gtk
$ LANG=C xdg-user-dirs-gtk-update
```

### capsLockの扱い
```
# CapsLockキーとCtrlキーを入れ替える
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:swapcaps']"

# CapsLockキーを追加のCtrlキーとして使う
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"

# CapsLockキーの動作をデフォルトに戻す場合
dconf reset /org/gnome/desktop/input-sources/xkb-options
```

### 日本語入力を有効にする
```
$ sudo apt-get install ibus-mozc
$ sudo apt-get install ibus-gtk ibus-gtk3 ibus-qt4

# iBus設定
$ ibus-setup

# cinnamon

# GNOME3
設定 → Region&Language → 入力ソース → 英語(US) と 日本語(Mozc)
設定 → Keyboard → タイピング → インプットメソッドの切り替えキーを設定
再起動
```


## ターミナルの設定を更新
```
$ \
rm -f ~/.bash_bash_script.bash; \
wget -O ~/.bash_bash_script.bash https://raw.githubusercontent.com/shogysd/settings/master/config_files/bash_script.bash; \
source ~/.bash_bash_script.bash; \
config-update
```

## インストール
```
$ \
sudo apt-get -y update; \
sudo apt-get -y upgrade; \
sudo apt-get -y install git; \
```
