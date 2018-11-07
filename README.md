# Setting

## Run (bash config)
```
$ \
rm -f ~/.bash_bash_script.bash; \
wget -O ~/.bash_bash_script.bash https://raw.githubusercontent.com/shogysd/settings/master/config_files/bash_script.bash; \
source ~/.bash_bash_script.bash; \
config-update
```

## Run (Linux full-setup)
```
$ su
[Type root pass]

$ wget -O ./ap-set.sh https://raw.githubusercontent.com/shogysd/settings/master/ap-set.sh
$ chmod 777 ./ap-set.sh
$ ./ap-set.sh
$ rm ./ap-set.sh
$ exit

$ wget -O ./setting.sh https://raw.githubusercontent.com/shogysd/settings/master/setting.sh
$ chmod 744 ./setting.sh
$ ./setting.sh
```

## Run Git setup (macOS/Linux)
```
$ curl -o ~/gitconfigscript.sh https://raw.githubusercontent.com/shogysd/settings/master/gitconfigscript.sh
$ chmod 744 ./gitconfigscript.sh
$ ./gitconfigscript.sh
```
