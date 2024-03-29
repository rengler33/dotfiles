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

## Note on WSL internet troubles
I have sometimes had a lot of difficulty maintaining an internet connection inside the WSL2 environment. This is always due to something about `/etc/resolv.conf`, which WSL tries to automatically set. Docker Desktop seems to interfere, and VPNs will definitely mess this up. I generally fix it by removing the "auto-generated" file (which sometimes is just a symlink that doesn't actually point to a file??) and replacing it with a file that has the following contents: `nameserver 8.8.8.8` (google's nameserver), or if I'm behind a VPN I look up the specific nameservers I will need. I don't know enough about networking to understand this issue deeper.


## Installs inside WSL2

```sh
sudo apt update && sudo apt install -y \
  curl \
  ffmpeg \
  git \
  htop \
  python3-pip \
  python3-venv \
  rsync \
  unzip \
  vim \
  tmux \
  neovim
```

Close wsl2 and re-open (or logout/login) so PATH can be updated
 
### Pyenv and Poetry install
[Pyenv](https://github.com/pyenv/pyenv-installer) and [Poetry](https://python-poetry.org/docs/#installation) are best installed through their installer scripts called out in their documentation.

### Set up SSH keys
ensure the following:
```sh
chmod 700 ~/.ssh/
chmod 644 ~/.ssh/<publickey>.pub
chmod 600 ~/.ssh/<privatekey>
```

Probably want to set up ssh-agent (if below command doesn't work, you may need to specify filepath specifically):
```
ssh-add -l
```

To start:
```
eval `ssh-agent`
```

### Clone dotfiles repo

SSH
```sh
git clone git@github.com:rengler33/dotfiles.git ~/github/dotfiles/
```

#### Create symlinks to various dotfiles.
```sh
ln -s ~/github/dotfiles/.bash_aliases ~/.bash_aliases && \
ln -s ~/github/dotfiles/.gitconfig ~/.gitconfig && \
ln -s ~/github/dotfiles/.vimrc ~/.vimrc && \
sudo ln -s ~/github/dotfiles/etc/wsl.conf /etc/wsl.conf
```

### After editing the .gitconfig.user file to be personally relevant:
```sh
cp ~/github/dotfiles/.gitconfig.user ~/.gitconfig.user
```

### If using VPN, WSL2 will likely require you to configure their nameservers:
My example file has the nameservers for NordVPN
```sh
sudo rm -r /etc/resolv.conf && sudo cp ~/github/dotfiles/etc/resolv.conf /etc/resolv.conf
```

Note: if the file is designated "immutable", you will need to use `chattr` to first be able to edit it. As superuser and owner of the file (root):
```bash
chattr -i /etc/resolv.conf
vim /etc/resolv.conf
chattr +i /etc/resolv.conf
```

### Remove incredibly annoying Windows ding sound while in bash
Go to /etc/inputrc and (as privileged user) umcomment/add line `set bell-style none`


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

Install global python packages with pipx
```sh
pipx install \
pipenv \
cookiecutter \
flake8 \
black \
isort \
pytest \
pre-commit \
youtube-dl
```

Install AWS CLI V2
```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip && sudo ./aws/install && rm awscliv2.zip
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
ffmpeg `
kodi `
vlc `
winscp.install `
qbittorrent `
zoom `
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
vscode-insiders `
postman
```

### Additional Windows Steps

Install MesloLGS NF font https://github.com/romkatv/dotfiles-public/tree/master/.local/share/fonts/NerdFonts (this is a good font that works well with oh-my-zsh and powerlevel10k)

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

### Useful Extensions
- Remote Development (Extension Pack)
- Vim
- Docker
- GitLens
- Rainbow Brackets
- Python
- Pylance
- Python Docstring Generator
- Python Indents
- Jupyter

## Pycharm Settings
To be inside WSL automatically change default terminal from `cmd.exe` to `bash.exe`

## Docker / WSL2 settings & best practices
https://docs.docker.com/docker-for-windows/wsl/

https://docs.microsoft.com/en-us/windows/wsl/compare-versions#use-the-linux-file-system-for-faster-performance


## SMB Network shares
Install `sudo apt install cifs-utils`

Create a file in `~/.smbcredentials` that looks like this:

```
username=<USERNAME>
password=<PASSWORD>
```
Run `sudo chmod 600 ~/.smbcredentials` to lock down file permissions on that file.

Edit `/etc/fstab` to include a line with the following:
```
//<SERVER>/<SHARE> <MOUNTPATH> cifs rw,credentials=~/.smbcredentials,iocharset=utf8,nounix,file_mode=0777,dir_mode=0777 0 0
```
Note the mountpath will need folders that already exist, e.g. `/mnt/hagrid/courses`

Run `sudo mount -a` to mount the paths.
