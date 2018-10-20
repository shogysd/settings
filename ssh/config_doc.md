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
```
Host [name]
  RemoteForward 52698 127.0.0.1:52698
```
