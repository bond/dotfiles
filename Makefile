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
	@rm -f ~/.config/$@
	@ln $(LN_FLAGS) $(PWD)/dot.config/$@ ~/.config/$@

install: $(symlinks) $(symdirs) awesome
	@echo
	@echo symlinks installed: [$^]
	@echo -e \\nFor more information see: http://github.com/bond/dotfiles
