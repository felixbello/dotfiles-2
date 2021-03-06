.PHONY: help install

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Installs dotfiles into current environment
	@$(MAKE) DOTFILE=.aliases install_file
	@$(MAKE) DOTFILE=.atom/config.cson install_file
	@$(MAKE) DOTFILE=.exports install_file
	@$(MAKE) DOTFILE=.functions install_file
	@$(MAKE) DOTFILE=.gitconfig install_file
	@$(MAKE) DOTFILE=.gitignore install_file
	@$(MAKE) DOTFILE=.hyper.js install_file
	@$(MAKE) DOTFILE=.oh-my-zsh/themes/eko.zsh-theme install_file
	@$(MAKE) DOTFILE=.sources install_file
	@$(MAKE) DOTFILE=.tmux.conf install_file
	@$(MAKE) DOTFILE=.vimrc install_file
	@$(MAKE) DOTFILE=.zshrc install_file

install-encrypted: ## Installs encrypted dotfiles into current environment
	@$(MAKE) DOTFILE=.ssh/config install_encrypted_file

install_file:
	@if [ ! -f ${HOME}/${DOTFILE} ]; then \
		echo ✔ Installing file: ${HOME}/${DOTFILE}; \
		cp ${DOTFILE} ${HOME}/${DOTFILE}; \
	else \
		echo ✖ File already exists: ${HOME}/${DOTFILE}; \
	fi \

install_encrypted_file:
	@if [ ! -f ${HOME}/${DOTFILE} ]; then \
		echo ✔ Installing encrypted file: ${HOME}/${DOTFILE}; \
		gpg2 --decrypt .encrypted/${DOTFILE} 2> /dev/null > ${HOME}/${DOTFILE}; \
	else \
		echo ✖ File already exists: ${HOME}/${DOTFILE}; \
	fi \
