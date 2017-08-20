apt-get update
apt-get -y install vim most git wget curl

cd ~
git clone https://github.com/NickSavage/dotfiles.git
rm ~/.bashrc
ln -s ~/dotfiles/.bash_profile ~
ln -s ~/dotfiles/.bashrc ~
source .bash_profile
