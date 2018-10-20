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
