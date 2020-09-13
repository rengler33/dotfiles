# dotfiles

A few settings files for my current development setup

I'm running Windows 10, using WSL2 with Ubuntu for development.


I prefer to use Docker Desktop and configure Pycharm to use that as a remote interpreter. I also develop with VS Code in a similar way.

Project files are kept inside a WSL2 folder location.

Copy the items in the C/ folder manually to the Windows system.

Inspired by https://github.com/nickjj/dotfiles

## Ubuntu 20.04 inside WSL2

```sh
sudo apt-get update && sudo apt-get install -y \
  curl \
  ffmpeg \
  git \
  htop \
  python3-pip \
  unzip \
  vim
```
 
### Clone dotfiles repo

```sh
git clone https://github.com/rengler33/dotfiles ~/dotfiles

# Create symlinks to various dotfiles.
ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases \
&& ln -s ~/dotfiles/.gitconfig ~/.gitconfig \
&& sudo ln -s ~/dotfiles/etc/wsl.conf /etc/wsl.conf
```

### After editing the .gitconfig.user file to be personally relevant:
```sh
cp ~/dotfiles/.gitconfig.user ~/.gitconfig.user
```

### Install AWS CLI V2
```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip && sudo ./aws/install && rm awscliv2.zip
```
  
### Install Heroku CLI
```sh
curl https://cli-assets.heroku.com/install.sh | sh
```

## Pycharm Settings
To be inside WSL automatically change default terminal from `cmd.exe` to `bash.exe`

## Windows Installs (using Chocolatey) from Powershell prompt (opened as administrator)
```powershell
choco install `
firefox `
googlechrome `
nordvpn `
microsoft-windows-terminal `
powertoys ` 
autohotkey.install `
ditto `
7zip.install `
vcredist140 `
putty.install `
curl `
youtube-dl `
ffmpeg `
kodi `
vlc `
foobar2000 `
winscp.install `
qbittorrent `
zoom `
Skype `
obs-studio `
sizer `
calibre `
kindle `
Adobereader `
vim `
markdownmonster `
notepadplusplus.install `
steam `
epicgameslauncher `
docker-desktop `
pycharm `
vscode `
firacode `
postman `
git.install

```
