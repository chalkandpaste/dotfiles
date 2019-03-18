# apt-get installs
apt-get install zsh
apt-get install neovim
apt-get install tmux
apt-get install reattach-to-user-namespace

# setup zsh
#command -v zsh | sudo tee -a /etc/shells
#chsh -s zsh

# install powerline modified fonts
#sh ./fonts/install.sh

# setup tmux
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tmux ~/.tmux

# setup prezto
ln -fs ~/dotfiles/prezto ~/.zprezto
ln -fs ~/dotfiles/prezto/runcoms/zlogin ~/.zlogin
ln -fs ~/dotfiles/prezto/runcoms/zlogout ~/.zlogout
ln -fs ~/dotfiles/prezto/runcoms/zpreztorc ~/.zpreztorc
ln -fs ~/dotfiles/prezto/runcoms/zprofile ~/.zprofile
ln -fs ~/dotfiles/prezto/runcoms/zenv ~/.zenv
ln -fs ~/dotfiles/prezto/runcoms/zshenv ~/.zshenv
ln -fs ~/dotfiles/zshrc ~/.zshrc

# setup vim configs
rm -rf ~/.vim
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.nvim

# link for neovim
mkdir ~/.config/
mkdir ~/.config/nvim
ln -s ~/dotfiles/vim/vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/vim ~/.local/share/nvim/site
