# Windows Subsystem for Linux

Steps to configure WSL to work with this profile. Also includes other helpful config, such as Docker.

## Update system

```
sudo apt update
sudo apt upgrade -y
```

## zsh

### Install

```
sudo apt install -y zsh
```

### Set as default shell

WSL always starts `bash`, so we have to tell `bash` to start `zsh`. Put this at the bottom of `~/.bashrc`:

```sh
if [ -t 1 ]; then
  exec zsh
fi
```

### Use this profile

```
cd ~
git clone https://github.com/frigus02/zsh-profile.git
cd zsh-profile
make install

# Fix permissions
chmod -R 755 ~/zsh-profile/modules
chmod -R 755 ~/.zfunctions
```

## Docker

Based on: https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly

### Install

```
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt install -y docker-ce
sudo usermod -aG docker $USER
```

### Fix volume mounting

1. Mount Windows file system under `/c` instead of `/mnt/c`.

   ```
   sudo vi /etc/wsl.conf
   ```

   Make it look like this and save the file:

   ```
   [automount]
   root = /
   ```

2. Sign out and back in on Windows.

### Connect to Docker Desktop

1. Docker on Windows / Settings / Generate: enable "Expose daemon on tcp://localhost:2375 without TLS"

2. Tell WSL where to look by adding this to `~/.bashrc`:

   ```sh
   export DOCKER_HOST=tcp://localhost:2375
   ```

## Other

### git

```
git config --global user.name ""
git config --global user.email ""
```

### ls

To improve colors of `ls` for files and directories with 777 permissions, put this in `~/.bashrc`:

```sh
export LS_COLORS="ow=01;36;40"
```

### kubectl

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl completion zsh > ~/.zfunctions/_kubectl
mkdir ~/.kube
cp /c/Users/<WINDOWS_USER_NAME>/.kube/config ~/.kube/config
```

### stern

```
curl -L https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 -o stern
chmod +x ./stern
sudo mv ./stern /usr/local/bin/stern
stern --completion zsh > ~/.zfunctions/_stern
```

### kyml

```
curl -L https://github.com/frigus02/kyml/releases/download/v20190906/kyml_20190906_linux_amd64 -o kyml
chmod +x ./kyml
sudo mv ./kyml /usr/local/bin/kyml
kyml completion zsh > ~/.zfunctions/_kyml
```
