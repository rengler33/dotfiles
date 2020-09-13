# dotfiles

A few settings files for my current development setup

I'm running Windows 10, using WSL2 with Ubuntu for development.

I prefer to use Docker Desktop and configure Pycharm to use that as a remote interpreter. I also develop with VS Code in a similar way.

Project files are kept inside a WSL2 folder location.

Inspired by https://github.com/nickjj/dotfiles

## Ubuntu 20.04

sudo apt-get update && sudo apt-get install -y \
  curl \
  git \
  htop \
  python3-pip \
  unzip \
  vim
 
 
## Clone dotfiles repo
git clone https://github.com/rengler33/dotfiles ~/dotfiles

ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases \
&& ln -s ~/dotfiles/.gitconfig ~/.gitconfig \
&& sudo ln -s ~/dotfiles/etc/wsl.conf /etc/wsl.conf

### After editing the .gitconfig.user file to be personally relevant:
cp ~/dotfiles/.gitconfig.user ~/.gitconfig.user

## Install AWS CLI V2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip && sudo ./aws/install && rm awscliv2.zip
  
## Install Heroku CLI
curl https://cli-assets.heroku.com/install.sh | sh
