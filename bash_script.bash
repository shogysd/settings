# Time-stamp: <Sat Mar 24 22:57:20 JST 2018>

os=`uname 2>&1`
if [ ${os} = "Darwin" ]; then
    # macOS
    emacs_PATH='/Applications/Emacs.app/Contents/MacOS/Emacs'
    esc_key='\033'
    download_command='curl -# -o'
    git_command_path='/usr/bin/git'
else
    # Linux ${os} = "Linux"
    emacs_PATH='emacs'
    esc_key='\e'
    download_command='wget -O'
    git_command_path='/usr/bin/git'
fi


function strcmp(){
    if [ $# = 0 ]; then
        echo "error: nothing arguments"
    elif [ $# = 1 ]; then
        echo "error: inadequate arguments"
    elif [ $# -gt 2 ]; then
        echo "error: many arguments"
    else
        if [ "$1" = "$2" ]; then
            echo "True"
        else
            echo "False"
        fi
    fi
}


function clfmt(){
    find . -name "*.h" | xargs clang-format -i -style=Google
    find . -name "*.c" | xargs clang-format -i -style=Google
    find . -name "*.hpp" | xargs clang-format -i -style=Google
    find . -name "*.cpp" | xargs clang-format -i -style=Google
    find . -name "*.cc" | xargs clang-format -i -style=Google
    find . -name "*.cp" | xargs clang-format -i -style=Google
    find . -name "*.cxx" | xargs clang-format -i -style=Google
}


function shis(){
    if [ $# = 1 ]; then
        history | grep --color=auto $1
    elif [ $# = 0 ]; then
        echo "error: nothing arguments"
    else
        echo "error: many arguments"
    fi
}


function ema(){
    if [ $# = 0 ]; then
        ${emacs_PATH}
    elif [ $# = 1 ]; then
        if [ "$1" = "-nw" ] || [ "$1" = "nw" ] ; then
            ${emacs_PATH} -nw
        elif [ -d $1 ]; then
            echo "error: $1 is directory"
        elif [ -f $1 ]; then
            ${emacs_PATH} $1
        else
            ls $1 2>&1 | awk '{print substr($0, 5)}'
        fi
    elif [ $# = 2 ]; then
        fname="."
        if [ "$1" = "-nw" ] || [ "$1" = "nw" ] ; then
            fname="$2"
        elif [ "$2" = "-nw" ] || [ "$2" = "nw" ]; then
            fname="$1"
        else
            echo "error: arguments err"
            return -1
        fi
        if [ -d ${fname} ]; then
            echo "error: ${fname} is directory"
        elif [ -f ${fname} ]; then
            ${emacs_PATH} -nw ${fname}
        else
            ls ${fname} 2>&1 | awk '{print substr($0, 5)}'
        fi
    else
        echo "error: many arguments"
    fi
}


function flush(){
    ls -A *~ &> /dev/null
    if [ $? = 0 ]; then
        rm *~
    fi
    ls -A .*~ &> /dev/null
    if [ $? = 0 ]; then
        rm .*~
    fi
    ls -A \#*\# &> /dev/null
    if [ $? = 0 ]; then
        rm \#*\#
    fi
}


function gd(){
    topLevelPath=`${git_command_path} rev-parse --show-toplevel 2> /dev/null`
    if  [ $? = 0 ]; then
        cd ${topLevelPath}
    else
        echo "error: out of git"
    fi
}


function -pathWriter(){
    if ${git_command_path} rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        if [ -z "$(git status --porcelain)" ]; then
            # branch is clean
            if [ -f ~/.gitignore_global ]; then
                # ~/.gitignore_global is enabled
                echo -n "git: "
            else
                # ~/.gitignore_global is disabled
                echo -ne "${esc_key}[0;39;7mgit:${esc_key}[0;39m "
            fi
        else
            # branch is not clean
            if [ -f ~/.gitignore_global ]; then
                # ~/.gitignore_global is enabled
                echo -ne "${esc_key}[1;31mgit:${esc_key}[0;39m "
            else
                # ~/.gitignore_global is disabled
                echo -ne "${esc_key}[1;31;7mgit:${esc_key}[0;39m "
            fi
        fi

        echo -n "`${git_command_path} rev-parse --show-toplevel | awk -F'/' '{printf $NF}'`/"
        ${git_command_path} rev-parse --show-prefix
    else
        pwd
    fi
}


function -gitBranchPrinter(){
    gitBranch=`${git_command_path} symbolic-ref --short HEAD 2> /dev/null`
    if [ $? = 0 ]; then
        if [ ${gitBranch} = "master" ]; then
            echo -n "${esc_key}[0;33mmaster${esc_key}[0;39m"
        else
            echo -n "${gitBranch}"
        fi
    else
        echo -n "${esc_key}[0;36mdetached${esc_key}[0;39m"
    fi
}


function -gitHashPrinter(){
    gitHash=`${git_command_path} rev-parse HEAD 2> /dev/null | awk '{print substr($0, 0, 7)}'`
    if [ $? = 0 ]; then
        echo -n "${gitHash}"
    else
        echo -n "Not committed"
    fi
}


function -gitChecker(){
    if ${git_command_path} rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo -e " < `-gitBranchPrinter` | `-gitHashPrinter` >"
    fi
}


#==================================================#


function config-update(){
    echo ""
    echo "auto setup script for Debiaconfig file updater"
    echo "updateApps: bash, emacs, git"
    echo -n "start setup?: y-or-n: "
    read start
    echo ""
    if [ $start = "y" ]; then
        rm ~/.bash_profile ~/.bashrc ~/.bash_script.bash ~/.inputrc ~/.screenrc ~/.emacs ~/.git-completion.bash  > /dev/null 2>&1
        echo -n "bash_profile ->"
        ${download_command} ~/.bash_profile https://raw.githubusercontent.com/shogysd/settings/master/bash_profile 2>&1 | awk -F ' ' '{print $2}'
        echo -n "bashrc ->"
        ${download_command} ~/.bashrc https://raw.githubusercontent.com/shogysd/settings/master/bashrc 2>&1 | awk -F ' ' '{print $2}'
        echo -n "bach_script ->"
        ${download_command} ~/.bash_script.bash https://raw.githubusercontent.com/shogysd/settings/master/bash_script.bash 2>&1 | awk -F ' ' '{print $2}'
        echo -n "gitignore-switch.bash ->"
        ${download_command} ~/.gitignore-switch.bash https://raw.githubusercontent.com/shogysd/settings/master/gitignore-switch.bash 2>&1 | awk -F ' ' '{print $2}'
        echo -n "screenrc ->"
        ${download_command} ~/.screenrc https://raw.githubusercontent.com/shogysd/settings/master/screenrc 2>&1 | awk -F ' ' '{print $2}'
        echo -n "emacs ->"
        ${download_command} ~/.emacs https://raw.githubusercontent.com/shogysd/settings/master/emacs 2>&1 | awk -F ' ' '{print $2}'
        echo -n "git-completion.bash ->"
        ${download_command} ~/.git-completion.bash https://raw.githubusercontent.com/shogysd/git/master/contrib/completion/git-completion.bash 2>&1 | awk -F ' ' '{print $2}'
        echo -n "gitconfigscript.sh ->"
        ${download_command} ~/gitconfigscript.sh https://raw.githubusercontent.com/shogysd/settings/master/gitconfigscript.sh 2>&1 | awk -F ' ' '{print $2}'
        chmod 744 ~/gitconfigscript.sh
        ~/gitconfigscript.sh
        rm ~/gitconfigscript.sh
        source ~/.bash_profile
    elif [ $start = "n" ]; then
        echo "EXIT"
    else
        echo "error"
    fi
}
