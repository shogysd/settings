# Linux (deb) の初期設定

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
上記作業後に "Configured directory for incoming files does not exists" と出る場合
```
$ gsettings set org.blueman.transfer shared-path '/home/[user-name]/Downloads/'
```
bluetooth manager → 表示 → ローカルサービス → 転送 → Incoming Folder → ディレクトリを確認

### capsLockの扱い
```
GNOME
# CapsLockキーとCtrlキーを入れ替える
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:swapcaps']"

# CapsLockキーを追加のCtrlキーとして使う
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"

# CapsLockキーの動作をデフォルトに戻す場合
dconf reset /org/gnome/desktop/input-sources/xkb-options
```
```
ThinkPadの場合 / 内蔵キーボード (tweakのUIから設定)
- Ctrl position
  - 'A'の左側
  - CapsLock を Ctrl として扱う
  - LeftAlt as Ctrl, LeftCtrl as Win, LeftWin as LeftAlt
```
```
ThinkPadの場合 / HHKB Mac-Mode (tweakのUIから設定)
- Ctrl position
  - CapsLock を Ctrl として使う
- Alt/Winキーの動作
  - Ctrl is mapped to Win and the usual CtrlKeys
```

### 日本語入力を有効にしたり、変換候補の表示場所をいい感じにする
```
$ sudo apt-get install ibus-mozc
$ sudo apt-get install ibus-gtk ibus-gtk3 ibus-qt4
```

##### GNOME3
```
設定 → Region&Language → 入力ソース → 日本語(Mozc)のみにする
設定 → Keyboard → タイピング → インプットメソッドの切り替えキーを設定 → 押さそうなやつにする
Mozcプロパティー → 一般 → キー設定 → 編集 → "直接入力" にIMEを有効化の設定を、"入力文字なし" にIMEを無効化の設定を入れる
iBusの設定から、インプットメソッドの切り替えを幼さそうなやつにする

再起動

# iBus設定を開くとしたら
# $ ibus-setup
```
キーマップは [ここ](https://github.com/shogysd/settings/blob/master/config_files/linux_mozc_keymap.txt) からダウンロードしてMozcにインポートでOK

### 鍵の設定
```
$ ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
id_rsa: 秘密鍵
id_rsa.pub: 公開鍵
```

### ~/.ssh/config
```
ServerAliveInterval 60

Host *
  AddKeysToAgent yes
  ForwardAgent yes
  HostKeyAlgorithms +ssh-dss
```
```
Host [name]
  HostName [ip]
  RemoteForward 52698 localhost:52698
```

## 電力の最適化
```
$ sudo apt-get install powertop
$ sudo apt-get install tlp
```
```
$ sudo powertop
の Tuneables が Good だといい感じになっている

tlp はインストールすると起動時に自動でそのへんを設定してくれる
```

## FUSEの設定
```
$ sudo apt-get install fuse
$ sudo modprobe fuse
$ sudo groupadd fuse
$ sudo usermod -a -G fuse `whoami`
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
sudo apt-get -y install make; \
sudo apt-get -y install curl; \
sudo apt-get -y install linux-headers-amd64; \
sudo apt-get -y install chromium; \
sudo apt-get -y install screen; \
sudo apt-get -y install mozc-utils-gui; \
sudo apt-get -y install fcitx-config-gtk
```
