# dotfiles

A few settings files for my current development setup

I'm running Windows 10, using WSL2 with Ubuntu for development.


I prefer to use Docker Desktop and configure VS Code to use that as a remote interpreter. I also develop with Pycharm in a similar way but have issues with the debugger so I've been leaning on VS Code.

Project files are kept inside a WSL2 folder location.

Inspired by https://github.com/nickjj/dotfiles

## Install WS2

https://docs.microsoft.com/en-us/windows/wsl/install-win10

Afterwards you can install Ubuntu or Debian or another distro

## Note on Debian

There is a possible bug related to the $PATH variables loading into WSL2. If you find you can't launch Windows binaries from inside WSL2 (like `code .`, they may not be in your PATH due to https://github.com/microsoft/WSL/issues/5779 . The solution is to remove the following lines from `/etc/profile`

```
if [ "`id -u`" -eq 0 ]; then
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
else
  PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
fi
```

## Installs inside WSL2

```sh
sudo apt update && sudo apt install -y \
  cookiecutter \
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
&& ln -s ~/dotfiles/.vimrc ~/.vimrc \
&& sudo ln -s ~/dotfiles/etc/wsl.conf /etc/wsl.conf
```

### After editing the .gitconfig.user file to be personally relevant:
```sh
cp ~/dotfiles/.gitconfig.user ~/.gitconfig.user
```

### If using VPN, WSL2 will likely require you to configure their nameservers:
My example file has the nameservers for NordVPN
```sh
sudo rm -r /etc/resolv.conf && sudo cp ~/dotfiles/etc/resolv.conf /etc/resolv.conf
```

### Additional installs inside WSL2

Install pip if needed
```sh
sudo apt update
sudo apt install python3-pip
```

Install pipx
```sh
python3 -m pip install --user pipx
python3 -m pipx ensurepath
```

Install pipenv
```sh
pipx install pipenv
```

Install AWS CLI V2
```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip && sudo ./aws/install && rm awscliv2.zip
```
  
Install Heroku CLI
```sh
curl https://cli-assets.heroku.com/install.sh | sh
```

## Windows Installs from Powershell prompt (opened as administrator)

### Installing Chocolatey
https://chocolatey.org/install
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

### Installing applications
```powershell
choco install -y `
firefox `
googlechrome `
nordvpn `
microsoft-windows-terminal `
powertoys ` 
autohotkey `
7zip.install `
putty.install `
curl `
youtube-dl `
ffmpeg `
kodi `
vlc `
winscp.install `
qbittorrent `
zoom `
Skype `
obs-studio `
sizer `
calibre `
kindle `
vim `
markdownmonster `
steam `
git.install `
docker-desktop `
pycharm `
vscode `
postman
```

### Additional Windows Steps

Copy the items in the C/ folder manually to the Windows system if they're needed.

Note that the `_vimrc` file needs the directory `~\vimtmp` to be created in order to store temporary files there specifically, otherwise it will use current directory.

### Autohotkey Script(s)
One AHK script I like to have is a minimize/un-minimize option for WindowsTerminal.exe, you can make it startup at login by placing the script in `C:\Users\`[your username]`\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`

# Notes

## Windows Terminal
You can change the default profile of windows terminal to be a WSL distro. You can also change the starting directory in the settings. See the example file.

Additionally you can create your own shortcut for windows terminal to open multiple tabs or panes using a target like this:
`wt -p "Ubuntu"; split-pane -p "Ubuntu"; new-tab -p "Windows PowerShell"; focus-tab -t 0`
See more about this here https://docs.microsoft.com/en-us/windows/terminal/command-line-arguments?tabs=windows

## VS Code
Start with installing the "Remote Development" extension pack, a group of useful remote extensions.

## Pycharm Settings
To be inside WSL automatically change default terminal from `cmd.exe` to `bash.exe`

## Docker / WSL2 settings & best practices
https://docs.docker.com/docker-for-windows/wsl/

https://docs.microsoft.com/en-us/windows/wsl/compare-versions#use-the-linux-file-system-for-faster-performance
