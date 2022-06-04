#! /bin/sh

DOTFILES_DIR=/workspaces/.codespaces/.persistedshare/dotfiles

echo "\n\n===== Change default shell ====="
sudo chsh -s $(which zsh) $(whoami)

echo "\n\n===== Installing packages ====="
sudo apt-get update
sudo apt-get install -y ack

echo "\n\n===== Install FZF ====="
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

echo "\n\n===== Install NeoVim ====="
curl -fLo  "${HOME}/tmp/nvim/nvim.appimage" --create-dirs https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x "${HOME}/tmp/nvim/nvim.appimage"
${HOME}/tmp/nvim/nvim.appimage --appimage-extract
sudo mv ./squashfs-root /opt/nvim
sudo ln -sf /opt/nvim/AppRun /usr/bin/nvim

echo "\n\n===== Remove RVM ====="
# From https://stackoverflow.com/a/25571648/33226
sudo /usr/local/rvm/bin/rvm implode --force 2>&1 >/dev/null
rm -rf /usr/local/rvm
sudo rm -f /etc/profile.d/rvm.sh

echo "\n\n===== Install vim-plug ====="
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "\n\n===== Installing oh-my-zsh ====="
sudo rm -fr ${HOME}/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "\n\n===== Clean up things we don't want ====="
sudo rm -f /usr/bin/gs
sudo mv /usr/bin/vi /usr/bin/vim
sudo ln -s /usr/bin/nvim /usr/bin/vi

echo "\n\n===== Symlink dotfiles ====="
mkdir -p "${HOME}/.config"
ln -sf ${DOTFILES_DIR}/zshrc ${HOME}/.zshrc
ln -sf ${DOTFILES_DIR}/gitconfig ${HOME}/.gitconfig
ln -sf ${DOTFILES_DIR}/config/nvim ${HOME}/.config/nvim

echo "\n\n===== Install VIM plugins ====="
vi --headless +PlugInstall +qall
