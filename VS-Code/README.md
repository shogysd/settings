# Visual Studio Code の設定

## 種類
| ファイル名 | 内容 |
| :-: | :-- |
| settings.json | ユーザー設定（デフォルトの上書き内容） |
| locale.json | 言語情報 |
| keybindings.json | キーバインドの情報 |

## PATH
| OS | PATH |
| :-: | :-- |
| Debian | ~/.config/Code/User/ |
| macOS X | ~/Library/Application Support/Code/User/ |

## パッケージ
https://marketplace.visualstudio.com/vscode

| パッケージ名 | 概要 | URL |
| :-: | :-- | :-- |
| zenkaku | 全角の可視化 | https://marketplace.visualstudio.com/items?itemName=mosapride.zenkaku |
| vscode-emacs-tab | Tabの挙動 | https://marketplace.visualstudio.com/items?itemName=garaemon.vscode-emacs-tab |
| Clock in status bar | ステータスバーに時間を表示 | https://marketplace.visualstudio.com/items?itemName=Compulim.vscode-clock |

### パッケージをインストール (CUIから)
```
$ \
code --install-extension mosapride.zenkaku; \
code --install-extension garaemon.vscode-emacs-tab; \
code --install-extension Compulim.vscode-clock; \
code --install-extension rafaelmaiolla.remote-vscode; \
code --install-extension jsynowiec.vscode-insertdatestring; \
code --install-extension ms-python.python; \
code --install-extension ms-vscode.cpptools; \
```
