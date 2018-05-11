all: install

install:
	cp -rf .vim ../
	cp .vimrc ../

update:
	cp ~/.vimrc .
