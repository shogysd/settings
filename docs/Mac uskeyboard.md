# Mac のUSキーボードの設定

MacのUSキーボードでaを押しっぱなしにても連続入力できない ( 記号の変換候補が出てくる )  
以下のコマンドで連続入力に変更できる
```
$ defaults write -g ApplePressAndHoldEnabled -bool false
```
