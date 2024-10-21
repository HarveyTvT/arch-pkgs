#! /bin/bash

# official package
sudo pacman -S --needed - <pkglist-repo.txt

# aur package
sudo rm -rf yay
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd ..
yay -S --needed --noconfirm - <pkglist-aur.txt

# flatpak
xargs flatpak install -y <pkglist-flatpak.txt

# miniconda
mkdir -p ~/.miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/.miniconda3/miniconda.sh
bash ~/.miniconda3/miniconda.sh -b -u -p ~/.miniconda3
rm -rf ~/.miniconda3/miniconda.sh
~/.miniconda3/bin/conda init bash
~/.miniconda3/bin/conda init zsh
~/.miniconda3/bin/conda config --set auto_activate_base false
source ~/.bashrc
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# vim
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
if [ ! -f "/usr/bin/vi" ]; then cd /usr/bin && sudo ln -s vim vi; fi

# telepresence
sudo curl -fL https://app.getambassador.io/download/tel2oss/releases/download/v2.17.0/telepresence-linux-amd64 -o /usr/local/bin/telepresence
sudo chmod a+x /usr/local/bin/telepresence

# golang config
cd ~/Downloads
go env -w GOPATH=$HOME/go
go env -w GOPROXY=https://goproxy.cn,direct
go env -w CGO_ENABLED="0"
go env -w GOSUMDB=off
go env -w GO111MODULE=on
git config --global --add url."git@g.echo.tech:".insteadOf "http://g.echo.tech/"
git config --global --add url."git@g.echo.tech:".insteadOf "https://g.echo.tech/"

# zsh
sudo pacman -S --needed zsh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git config --global --add oh-my-zsh.hide-dirty 1
git config --global oh-my-zsh.hide-info 1

export ZSH_CUSTOM=$HOME/.oh-my-zsh
rm -rf $ZSH_CUSTOM/plugins/zsh-autosuggestions
rm -rf $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
rm -rf $ZSH_CUSTOM/plugins/fast-syntax-highlighting
rm -rf $ZSH_CUSTOM/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/g" ~/.zshrc

