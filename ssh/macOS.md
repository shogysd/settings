# sshconfig for macOS
path: ~/.ssh/config
```
Host *
  ServerAliveInterval 60
  UseKeychain yes
  AddKeysToAgent yes
  ForwardAgent yes
  HostKeyAlgorithms +ssh-dss
```
