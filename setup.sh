#! /bin/bash

echo "copying common dotfiles to .config ..."
ln -sr $HOME/dotfiles/{alacritty,ipython,ncspot,nvim,ranger,tmux} $HOME/.config
echo "creating uinput system group..."
sudo groupadd --system uinput
if [[ -z "$(grep '^input' /etc/group)" ]]; then
    echo "copying input group to /etc/group"
    grep -E '^input:' /usr/lib/group | sudo tee -a /etc/group
fi
echo "adding user to groups"
sudo usermod -aG input,uinput $USER

echo "copying kanata config and service to .config"
mkdir -p $HOME/.config/{systemd/user,kanata}
ln -sr $HOME/dotfiles/systemd/user/kanata.service $HOME/.config/systemd/user
systemctl --user daemon-reload
systemctl --user enable kanata.service
ln -sr $HOME/dotfiles/kanata/kanata.kbd $HOME/.config/kanata

echo "copying .basrc, .inputrc, and .bash_profile"
mv $HOME/.bashrc $HOME/.bashrc.bak
mv $HOME/.bash_profile $HOME/.bash_profile.bak
cp $HOME/.bash_profile.base $HOME/.bash_profile
ln -s $HOME/dotfiles/.bashrc* $HOME/
ln -s $HOME/dotfiles/.inputrc $HOME/

echo "adding udev rules"
sudo cp $HOME/dotfiles/udev/* /etc/udev/rules.d/

echo "done. reboot to see changes"
