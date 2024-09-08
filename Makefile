LN_FLAGS = -sf

symlinks = .zshrc .gitconfig .tmux.conf
symdirs = .zsh
config_dirs = alacritty hypr waybar
all: install


# Create the symlinks
$(symlinks):
	@ln $(LN_FLAGS) $(PWD)/dot$@ ~/$@

$(symdirs):
	@rm -f ~/$@
	@ln $(LN_FLAGS) $(PWD)/dot$@/ ~/$@

$(config_dirs):
	@test -d ~/.config/$@ && mv ~/.config/$@ ~/.config/$@.bak
	@ln $(LN_FLAGS) $(PWD)/dot.config/$@ ~/.config/$@

install: $(symlinks) $(symdirs) $(config_dirs)
	@echo
	@echo symlinks installed: [$^]
	@echo -e \\nFor more information see: http://github.com/bond/dotfiles
