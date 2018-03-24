# emacs設定関連のメモ


## 設定ファイルに書かれているパッケージ
| キー | 内容 | 有効 |
| :-: | :-- | :-: |
| auto-complete | 入力補完 | T |
| fuzzy | auto-completeの曖昧補完 | T |
| clang-format | c/cpp の整形 | T |
| idea-darkula-theme | intellijみたいな色 | F |
| highlight-indentation | インデントの可視化 | F |
| go-mode | go言語のパッケージ | F |


## list-packages のメモ（パッケージを入れたりするときに使う）
| キー | 内容 |
| :-: | :-- |
| i | インストールするパッケージにマークをつける |
| d | 削除するパッケージにマークをつける |
| u | マークを削除 |
| r | パッケージ一覧を更新 |
| U | インストールしたパッケージのアップデートのマークをつける |
| x | 実行 |
| q | 終了 |
| h | ヘルプを表示 |


## キーバインドの表示
| コマンド | 内容 |
| :-: | :-- |
| M-x describe-bindings | 一覧表示 |
| M-x describe-key | バインドから検索 |


## テーマのメモ
- 明系統
  - adwaita
  - dichromacy
  - light-blue
  - tango
  - tsdh-light
  - whiteboard
- 暗系統
  - deeper-blue
  - manoj-dark
  - misterioso
  - tango-dark
  - tsdh-dark
  - wheatgrass
  - wombat


## Macに "GNU Emacs For Mac OS X" を入れた時のPATH
/Applications/Emacs.app/Contents/MacOS/Emacs


## 一時的にインデントのソフトタブとハードタブを切り替える
```
M-x set-variable indent-tabs-mode
t    : tab
nill : space
```
