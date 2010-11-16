LN_FLAGS = -si

symlinks = .zshrc .screenrc

all: install


# Create the symlinks
$(symlinks):
	@ln $(LN_FLAGS) $(PWD)/dot$@ ~/$@

install: $(symlinks)
	@echo -e \\n
	@echo symlinks should be installed, for more information see http://github.com/bond/dotfiles
	@echo
