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
```

## 普段使用するユーザー側での作業
[/initial_setup/setting.debian.sh](https://github.com/shogysd/settings/blob/master/initial_setup/setting.debian.sh) を実行する
```
$ wget -O ~/setting.debian.sh https://raw.githubusercontent.com/shogysd/settings/master/initial_setup/setting.debian.sh
$ chmod 744 ~/setting.debian.sh
$ ~/setting.debian.sh | tee ~/setting.debian.sh.log
```
