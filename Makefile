LN_FLAGS = -sf

symlinks = .zshrc .gitconfig .tmux.conf
symdirs = .zsh
all: install


# Create the symlinks
$(symlinks):
	@ln $(LN_FLAGS) $(PWD)/dot$@ ~/$@

$(symdirs):
	@rm -f ~/$@
	@ln $(LN_FLAGS) $(PWD)/dot$@/ ~/$@

install: $(symlinks) $(symdirs)
	@echo
	@echo symlinks installed: [$^]
	@echo -e \\nFor more information see: http://github.com/bond/dotfiles
