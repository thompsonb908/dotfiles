#!/bin/bash

# Tmux
which -s tmux
if [[ $? != 0 ]]; then
    sudo apt install tmux
fi

if [[ ! -e ~/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# install MesloLGS Fonts
if [[ ! -f "~/.fonts/MesloLGS NF Regular.ttf" ]]; then
    wget "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf" -O "~/.fonts/MesloLGS NF Regular.ttf"
    wget "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf" -O "~/.fonts/MesloLGS NF Bold.ttf"
    wget "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf" -O "~/.fonts/MesloLGS NF Italic.ttf"
    wget "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf" -O "~/.fonts/MesloLGS NF Bold Italic.ttf"
    fc-cache -fv &>/dev/null
fi

if [[ ! -f "~/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
git clone https://github.com/thompson908/dotfiles ~/.dotfiles
~/.dotfiles/makesymlinks.sh

