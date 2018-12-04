# Time-stamp: <Mon Sep 17 13:21:50 JST 2018>

os=`uname 2>&1`

if [ ${os} = "Darwin" ]; then
    # macOS
    emacs_PATH='/Applications/Emacs.app/Contents/MacOS/Emacs'
    esc_key='\033'
    download_command='curl -o'
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
        history | \
            sed '$d' | \
            awk 'match($0, /.{5} {2}[^ ]{8} {1}[^ ]{10} {3}.*?'${1}'.*?/) { \
                    split($0, tmp, " "); \
                    printf "%5s  %8s %10s   ", tmp[1], tmp[2], tmp[3]; \
                    gsub("'${1}'", "\033[1;31m'${1}'\033[0;39m", $0); \
                    match($0, /.{5} {2}[^ ]+? {1}[^ ]+? {3}/); \
                    print substr($0, RSTART+RLENGTH) \
                }' | \
            tail -n 100
        # 2>/dev/null
        return 0
    elif [ $# = 0 ]; then
        echo "error: nothing arguments"
        return 1
    else
        echo "error: many arguments"
        return 1
    fi
}


function gitignore-sw(){
    if [ $# != 1 ]; then
        echo "error: arguments err"
    elif [ "$1" = "-e" ] || [ "$1" = "--enable" ]; then
        if [ -f ~/.gitignore_global ]; then
            echo "gitignore_global is already enable"
        elif [ -f ~/.gitignore_global_disable ]; then
            mv ~/.gitignore_global_disable ~/.gitignore_global
            echo "enabled: ~/.gitignore_global"
        else
            echo "error: not found: gitignore file"
        fi
    elif [ "$1" = "-d" ] || [ "$1" = "--disable" ]; then
        if [ -f ~/.gitignore_global_disable ]; then
            echo "gitignore_global is already disable"
        elif [ -f ~/.gitignore_global ]; then
            mv ~/.gitignore_global ~/.gitignore_global_disable
            echo "disable: ~/.gitignore_global"
        else
            echo "error: not found: gitignore file"
        fi
    elif [ "$1" = "-s" ] || [ "$1" = "--ststus" ]; then
        if [ -f ~/.gitignore_global ]; then
            echo "gitignore_global is enable"
        elif [ -f ~/.gitignore_global_disable ]; then
            echo "gitignore_global is disable"
        else
            echo "error: not found: gitignore file"
        fi
    else
        echo "error: $1 is unauthorized argument"
    fi
}


function hosts-sw(){
    if [ $# != 1 ]; then
        echo "error: arguments err"
    elif [ "$1" = "-e" ] || [ "$1" = "--enable" ]; then
        if [ -f /etc/hosts ]; then
            echo "/etc/hosts is already enable"
        elif [ -f /etc/hosts_disable ]; then
            sudo mv /etc/hosts_disable /etc/hosts
            echo "enabled: /etc/hosts"
        else
            echo "error: not found: /etc/hosts file"
        fi
    elif [ "$1" = "-d" ] || [ "$1" = "--disable" ]; then
        if [ -f /etc/hosts_disable ]; then
            echo "/etc/hosts is already disable"
        elif [ -f /etc/hosts ]; then
            sudo mv /etc/hosts /etc/hosts_disable
            echo "disable: /etc/hosts"
        else
            echo "error: not found: gitignore file"
        fi
    elif [ "$1" = "-s" ] || [ "$1" = "--ststus" ]; then
        if [ -f /etc/hosts ]; then
            echo "/etc/hosts is enable"
        elif [ -f /etc/hosts_disable ]; then
            echo "/etc/hosts is disable"
        else
            echo "error: not found: /etc/hosts file"
        fi
    else
        echo "error: $1 is unauthorized argument"
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
        \rm *~
    fi
    ls -A .*~ &> /dev/null
    if [ $? = 0 ]; then
        \rm .*~
    fi
    ls -A \#*\# &> /dev/null
    if [ $? = 0 ]; then
        \rm \#*\#
    fi
}


function screen-clean(){
    echo -n "cleanup detached screen?: y-or-n: "
    read start
    if [ $start = "y" ]; then
        for id in `screen -ls | grep -e '(' -e ')' | tr '.' ' ' | grep 'Detached' | awk '{print $1}'`; do
            screen -S ${id} -X quit
        done
    elif [ $start = "n" ]; then
        echo "EXIT"
    else
        echo "error"
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

function -envWriter(){
    envpath=`echo -n $VIRTUAL_ENV | awk -F'/' '{printf $NF}'`
    if [ -n "${envpath}" ]; then
        echo -n " < venv: "
        echo -n ${envpath}
        echo -n " >"
    fi
}


function -screenStarter(){
    # シェルの深さが1でSSHされている場合に起動
    if [ $SHLVL = 1 ] && [ "$TERM" != 'dumb' ] && [ "${SSH_CONNECTION}" != "" ]; then
        screen
    fi
}


function -screenPrinter(){
    if [ ${os} = "Darwin" ]; then
        argument_for_adjustment='1'
    else
        # Linux
        argument_for_adjustment='0'
    fi

    screen -ls | grep -q "Attached"
    if [ $? = 0 ]; then
        screen -ls | grep "Attached" | grep `expr ${PPID} - ${argument_for_adjustment}` > /dev/null
        if [ $? = 0 ]; then
            screen -ls | grep "Attached" | grep `expr ${PPID} - ${argument_for_adjustment}` | tr '.' ' ' | awk '{printf "%s %s", $1, $2}'
            return 0
        else
            # for counter in `seq 1 3`;
            # do
            #     predicted_id=`expr ${PPID} - ${argument_for_adjustment} - ${counter}`
            #     screen -ls | grep "Attached" | grep ${predicted_id} > /dev/null
            #     if [ $? = 0 ]; then
            #         screen -ls | grep ${pretected_id} | tr '.' ' ' | awk '{printf "%s %s", $1, $2}'
            #         echo -n " (estimated)"
            #         return 0
            #     fi
            # done
            echo -ne "PPID: ${PPID}"
            return 1
        fi
    else
        tty | cut -b 6-
        return 0
    fi
}


function -screenSessionPrinter(){
    if [ $SHLVL = 1 ] && [ "$TERM" != 'dumb' ] && [ "${SSH_CONNECTION}" != "" ]; then
        screen -ls | grep Attached | tr '.' ' ' | echo -e "${esc_key}[1;32m`awk '{printf "%s %s\t(Attached)\n", $1, $2}'`${esc_key}[0;39m"
        screen -ls | grep Detached | tr '.' ' ' | awk '{printf "%s %s\t(Detached)\n", $1, $2}'
    fi
}


#==================================================#

url_common='https://raw.githubusercontent.com/shogysd/settings/master/'
function config-update(){
    echo ""
    echo "auto setup script for Debiaconfig file updater"
    echo "updateApps: bash, emacs, git"
    echo -n "start setup?: y-or-n: "
    read start
    echo ""
    if [ $start = "y" ]; then

        update_files=("bash_profile"\
        "bashrc"\
        "bash_environments"\
        "bash_aliases"\
        "bash_script.bash"\
        "screenrc"\
        "emacs"\
        "gitignore_global")

        update_files_len=`expr ${#update_files[@]} - 1`

        for i in `seq 0 1 ${update_files_len}`
        do
            \rm ~/.${update_files[i]}
        done

        for i in `seq 0 1 ${update_files_len}`
        do
            echo "${update_files[i]}"
            ${download_command} ~/.${update_files[i]} ${url_common}config_files/${update_files[i]}
            echo ""
        done

        echo "git-completion.bash"
        ${download_command} ~/.git-completion.bash https://raw.githubusercontent.com/shogysd/git/master/contrib/completion/git-completion.bash
        echo ""

        echo "gitconfigscript.sh"
        ${download_command} ~/gitconfigscript.sh ${url_common}git-config/gitconfigscript.sh
        echo ""
        chmod 744 ~/gitconfigscript.sh
        ~/gitconfigscript.sh
        \rm ~/gitconfigscript.sh

        source ~/.bash_profile

    elif [ $start = "n" ]; then
        echo "EXIT"
    else
        echo "error"
    fi
}
