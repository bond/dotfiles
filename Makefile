LN_FLAGS = -sf

symlinks = .zshrc .screenrc

all: install


# Create the symlinks
$(symlinks):
	@ln $(LN_FLAGS) $(PWD)/dot$@ ~/$@

install: $(symlinks)
	@echo
	@echo symlinks should be installed: [$^]
	@echo -e \\nFor more information see: http://github.com/bond/dotfiles
