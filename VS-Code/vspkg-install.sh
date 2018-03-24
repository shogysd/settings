#!/bin/bash

# packages
pkglist=(
    # 全体設定
    garaemon.vscode-emacs-tab
    mosapride.zenkaku
    jsynowiec.vscode-insertdatestring
    # C/C++
    ms-vscode.cpptools
    mitaki28.vscode-clang
    austin.code-gnu-global
    # python
    ms-python.python
)

for pkgname in ${pkglist[@]}; do
    code --install-extension ${pkgname}
done
