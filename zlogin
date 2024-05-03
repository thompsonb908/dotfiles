# .zlogin

# load all files from .shell/login.d directory
if [ -d $HOME/dotfiles/login.d ]; then
    for file in $HOME/dotfiles/login.d/*.sh; do
        source $file
    done
fi

