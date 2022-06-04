#! /bin/sh

DOTFILES_DIR=/workspaces/.codespaces/.persistedshare/dotfiles

echo "\n\n===== Change default shell ====="
sudo chsh -s $(which zsh) $(whoami)

echo "\n\n===== Installing packages ====="
sudo apt-get update
sudo apt-get install -y ack

echo "\n\n===== Install FZF ====="
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

echo "\n\n===== Installing oh-my-zsh ====="
sudo rm -fr ${HOME}/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cat .zshrc > $HOME/.zshrc
cat .p10k.zsh > $HOME/.p10k.zsh

echo "\n\n===== Clean up things we don't want ====="
sudo rm -f /usr/bin/gs
sudo mv /usr/bin/vi /usr/bin/vim
sudo ln -s /usr/bin/nvim /usr/bin/vi

echo "\n\n===== Symlink dotfiles ====="
mkdir -p "${HOME}/.config"
ln -sf ${DOTFILES_DIR}/zshrc ${HOME}/.zshrc

