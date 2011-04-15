LN_FLAGS = -sf

symlinks = .zshrc .screenrc .emacs .gitconfig .Xdefaults .xsession
symdirs = .emacs.d
all: install


# Create the symlinks
$(symlinks):
	@ln $(LN_FLAGS) $(PWD)/dot$@ ~/$@

$(symdirs):
	@rm -f ~/$@
	@ln $(LN_FLAGS) $(PWD)/dot$@/ ~/$@

# config for awesomewm
awesome:
	@mkdir -p ~/.config
	@rm -f ~/.config/$@
	@ln $(LN_FLAGS) $(PWD)/dot.config/$@ ~/.config/$@

install: $(symlinks) $(symdirs)
	@echo
	@echo symlinks installed: [$^]
	@echo -e \\nFor more information see: http://github.com/bond/dotfiles

installx: $(symlinks) $(symdirs) awesome
	@echo
	@echo symlinks installed: [$^]
	@echo -e \\nFor more information see: http://github.com/bond/dotfiles
