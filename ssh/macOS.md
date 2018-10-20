# sshconfig for macOS
```
ServerAliveInterval 60

Host *
  UseKeychain yes
  AddKeysToAgent yes
  ForwardAgent yes
  HostKeyAlgorithms +ssh-dss
```
