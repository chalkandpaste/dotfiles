brew install zsh
brew install neovim
brew install tmux
brew install reattach-to-user-namespace

ln -s ~/dotfiles/tmux/tmux.conf .tmux.conf
ln -s ~/dotfiles/tmux ~/.tmux

# mac setup
chsh -s /usr/local/bin/zsh

ln -fs ~/dotfiles/prezto ~/.zprezto
ln -fs ~/dotfiles/prezto/runcoms/zlogin ~/.zlogin
ln -fs ~/dotfiles/prezto/runcoms/zlogout ~/.zlogout
ln -fs ~/dotfiles/prezto/runcoms/zpreztorc ~/.zpreztorc
ln -fs ~/dotfiles/prezto/runcoms/zprofile ~/.zprofile
ln -fs ~/dotfiles/prezto/runcoms/zenv ~/.zenv
ln -fs ~/dotfiles/prezto/runcoms/zshenv ~/.zshenv
ln -fs ~/dotfiles/zshrc ~/.zshrc

ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
# ln -s ~/dotfiles/vim/vimrc ~/dotfiles/vim/init.vim
ln -s ~/dotfiles/vim ~/.nvim
# ln -s ~/dotfiles/vimrc ~/.config/nvim/init.vim

