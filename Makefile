
install:
	git submodule update --init
	- mv ~/.vimrc ~/.vimrc.old
	ln -s ~/.vim/.vimrc ~/.vimrc
	- mv ~/.tmux.conf ~/.tmux.conf.old
	ln -s ~/.vim/tmux.conf ~/.tmux.conf
