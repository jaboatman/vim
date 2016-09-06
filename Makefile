
install:
	git submodule update --init
	- mv ~/.vimrc ~/.vimrc.old
	ln -s ~/.vim/.vimrc ~/.vimrc
