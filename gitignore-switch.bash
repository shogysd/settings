# Time-stamp: <Sun Mar 25 00:04:06 JST 2018>
if [ -f ~/.gitignore_global ]; then
    mv ~/.gitignore_global ~/.gitignore_global_disable
    echo "disabled: ~/.gitignore_global"
elif [ -f ~/.gitignore_global_disable ]; then
    mv ~/.gitignore_global_disable ~/.gitignore_global
    echo "enabled: ~/.gitignore_global"
else
    echo "error: ~/.gitignore_global not found"
fi
