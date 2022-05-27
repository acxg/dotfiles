#! /bin/sh

DOTFILES_DIR=/workspaces/.codespaces/.persistedshare/dotfiles

echo "\n\n===== Change default shell ====="
sudo chsh -s $(which zsh) $(whoami)

echo "\n\n===== Installing packages ====="
sudo apt-get update
sudo apt-get install -y ack

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
