LN_FLAGS = -sf

symlinks = .zshrc .screenrc .emacs .gitconfig
symdirs = .emacs.d
all: install


# Create the symlinks
$(symlinks):
	@ln $(LN_FLAGS) $(PWD)/dot$@ ~/$@

$(symdirs):
	ln $(LN_FLAGS) $(PWD)/dot$@/ ~/$@

install: $(symlinks) $(symdirs)
	@echo
	@echo symlinks should be installed: [$^]
	@echo -e \\nFor more information see: http://github.com/bond/dotfiles
