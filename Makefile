
install:
	git submodule update --init
	- cp ~/.vimrc ~/.vimrc.old
	ln -s ~/.vim/.vimrc ~/.vimrc
