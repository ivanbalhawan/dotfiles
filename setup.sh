#! /bin/bash

ln -sr $HOME/dotfiles/{alacritty,ipython,ncspot,nvim,ranger,tmux} $HOME/.config
sudo groupadd --system uinput
sudo usermod -aG input,uinput,render,video,audio $USER
mkdir -p $HOME/.config/{systemd/user,kanata}
ln -sr $HOME/dotfiles/systemd/user/kanata.service $HOME/.config/systemd/user
systemctl --user daemon-reload
systemctl --user enable kanata.service
ln -sr $HOME/dotfiles/kanata/kanata.kbd $HOME/.config/kanata

mv $HOME/.bashrc $HOME/.bashrc.bak
mv $HOME/.bash_profile $HOME/.bash_profile.bak
ln -s $HOME/dotfiles/.bashrc* $HOME/
ln -s $HOME/dotfiles/.inputrc $HOME/
