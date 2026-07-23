#!/usr/bin/env bash

# symlinks
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf

# install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm || true

# install nvim plugins
# nvim --headless "+Lazy! sync" +qa
