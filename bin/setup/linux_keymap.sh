# https://qiita.com/miy4/items/dd0e2aec388138f803c5

gsettings set org.gnome.desktop.input-sources xkb-options "['altwin:meta_win']"

gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab', '<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Alt>Tab', '<Shift><Super>Tab']"


sudo apt install pip3
sudo pip3 install xkeysnail

sudo groupadd uinput
sudo useradd -G input,uinput -M -s /usr/bin/nologin xkeysnail

xhost +SI:localuser xkeysnail
sudo -u xkeysnail DISPLAY=$DISPLAY /usr/local/bin/xkeysnail $HOME/share/dotfiles/config/xkeysnail/config.py


sudo groupadd uinput
sudo useradd -G input.uinpu -s /sbin/nologin xkeysnail
