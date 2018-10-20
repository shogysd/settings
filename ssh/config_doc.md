# sshconfig

## common
path: ~/.ssh/config
```
Host *
  ServerAliveInterval 60
  AddKeysToAgent yes
  ForwardAgent yes
  HostKeyAlgorithms +ssh-dss
```

mac only
```
Host *
  UseKeychain yes
```

## host
```
Host [name]
  HostName [hostname or ipaddr]
  User [username]
  Port [port no]
  IdentityFile [key path]
```

## remote forward
client
```
Host [name]
  RemoteForward 52698 127.0.0.1:52698
```
and editor setting

---
server
``
$ wget -O ~/.rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
$ chmod 744 ~/.rmate
```
