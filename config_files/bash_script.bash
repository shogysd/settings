os=`uname 2>&1`

if [ ${os} = "Darwin" ]; then
    # macOS
    emacs_PATH='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
    esc_key='\033'
    download_command='curl -s -o'
    git_command_path='/usr/bin/git'
else
    # Linux ${os} = "Linux"
    emacs_PATH='emacs -nw'
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


ULO_STRING=""
function ulo(){
    if [ "${ULO_STRING}" = "" ]; then
        find /usr/local/opt/*/bin -name bin ! -regex "/usr/local/opt/.*@.*/bin" -type d > /dev/null 2>&1

        if [ $? != 0 ]; then
            echo "ulo: '/usr/local/opt/*/bin' No such directory"
        else
            for p in `find /usr/local/opt/*/bin -name bin ! -regex "/usr/local/opt/.*@.*/bin" -type d`; do
                ULO_STRING="${p}:${ULO_STRING}"
            done
            export PATH="${ULO_STRING}"$PATH
            echo 'added: /usr/local/opt/*/bin'
        fi
    else
        export PATH=`echo $PATH | sed -e "s%${ULO_STRING}%%g"`
        ULO_STRING=""
        echo 'deleted: /usr/local/opt/*/bin'
    fi
}


function addpath(){
    if [ $# = 0 ]; then
        echo "error: nothing arguments"
    elif [ $# -gt 1 ]; then
        echo "error: many arguments"
    elif [ "$(echo $1 | rev | cut -c 1)" != "/" ]; then
        echo "$1 's late char is not '/'"
    else
        declare -a path_list=();
        path_list=${PATH//:/ };

        for path in ${path_list[@]};
        do
            if [ "$1" = "$path" ]; then
                echo "$1 is already exist in \$PATH"
                return 1
            fi
        done
        export PATH=$PATH":$1"
        return 0
    fi
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


# ------------------------------ #

function -l1Printer(){
    l1="${BASICINFO}  ( $(-pathWriter) )"
    l1git="$(-gitChecker)"
    l1len=$(echo "${l1}${l1git}" | tr -d "[:cntrl:]" | sed -e "s/\[[0-9]\{1,2\};[0-9]\{1,2\};\{0,1\}[0-9]\{1,2\}m//g" | wc -c | \
tr -d ' ')

    if [ ${l1len} -lt $(tput cols) ]; then
        echo "${l1}${l1git}"
    else
        echo "${l1}"
        echo "$(-basicInfoPrinter | sed -e 's/./ /g') ${l1git}"
    fi
}


function -gitBranchPrinter(){
    gitBranch=$(git symbolic-ref --short HEAD 2> /dev/null)
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
    gitHash=$(git rev-parse HEAD 2> /dev/null | awk '{print substr($0, 0, 7)}')
    if [ $? = 0 ]; then
        echo -n "${gitHash}"
    else
        echo -n "Not committed"
    fi
}


function -gitChecker(){
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo -e " < $(-gitBranchPrinter) | $(-gitHashPrinter) >"
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
        repo=`${git_command_path} rev-parse --show-toplevel | awk -F'/' '{printf $NF}'`
        gpath=`${git_command_path} rev-parse --show-prefix`
        echo "${repo}/${gpath}"
    else
        pwd
    fi
}


function -envWriter(){
    envpath=`echo -n $VIRTUAL_ENV | awk -F'/' '{printf $NF}'`
    if [ -n "${envpath}" ]; then
        echo -n "[ venv: "${envpath}" ] "
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
            echo -ne "PPID: ${PPID}"
            return 1
        fi
    else
        tty | cut -b 6-
        return 0
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
