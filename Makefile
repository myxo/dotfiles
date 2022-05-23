.PHONY: neovim
neovim: 
	./neovim/install.sh
	mkdir -p $$HOME/.config/nvim
	[ -d "$$HOME/.config/nvim/" ] || ln -s "$(pwd)/neovim/" "$$HOME/.config/nvim/"

.PHONY: git
git:
	./git/bootstrap.sh

.PHONY: zsh
zsh:
	./zsh/bootstrap.sh

.PHONY: tools
tools:
	sudo apt install lf
