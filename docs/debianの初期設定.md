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
GNOME
# CapsLockキーとCtrlキーを入れ替える
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:swapcaps']"

# CapsLockキーを追加のCtrlキーとして使う
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"

# CapsLockキーの動作をデフォルトに戻す場合
dconf reset /org/gnome/desktop/input-sources/xkb-options
```
```
cinnamon (コマンドではなぜかうまく行かなかった)
設定（コントロールセンター） → ハードウェア → キーボード → レイアウト → オプション(O)... → Ctrlキーの位置

```

### 日本語入力を有効にする
```
$ sudo apt-get install ibus-mozc
$ sudo apt-get install ibus-gtk ibus-gtk3 ibus-qt4
```

##### cinnamon
```
インプットメソッドの表示部分を右クリック → 設定 → 一般 → キーボードショートカット → 次の入力メソッド → 押さそうなやつにする
インプットメソッドの表示部分を右クリック → 設定 → 入力メソッド → 日本語(Mozc)のみにする
インプットメソッドの表示部分を右クリック → 設定 → 入力メソッド → 日本語(Mozc) を選択 → 設定 → 一般 → キー設定 → 編集 → 各モードのIME有効化・無効化を好きなキーバインドに変更
```

##### GNOME3
```
設定 → Region&Language → 入力ソース → 日本語(Mozc)のみにする
設定 → Keyboard → タイピング → インプットメソッドの切り替えキーを設定 → 押さそうなやつにする
Mozcプロパティー → 一般 → キー設定 → 編集 → 各モードのIME有効化・無効化を好きなキーバインドに変更

再起動

# iBus設定を開くとしたら
# $ ibus-setup
```

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
```
