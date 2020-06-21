# 概要
macOSでbashをビルドしてデフォルトシェルにしていする方法

# ソースコードの入手からインストール
[GNU Project](https://www.gnu.org/software/bash/) からソースコードをダウンロード

targzなので解凍する
```
$ tar zxvf bash-5.0.tar.gz
```

解凍したディレクトリに移動してビルそしてインストール
```
$ ./configure
$ make
$ make tests
$ make install
```

`/usr/local/bin/bash` にインストールされる

# デフォルトシェルの変更
`/etc/shells` にinstallしたbashのPATHを追加
```
sudo sh -c "echo '/usr/local/bin/bash' >> /etc/shells"
```

デフォルトのログインシェルを変更する
```
$ chsh -s /usr/local/bin/bash
```
