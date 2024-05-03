# .bashrc
if [[ $- != "i" ]] ; then
    # shell is non-interactive. be done now
    return
fi

# load all files from .shell/bashrc.d directory
if [ -d $HOME/.dotfiles/bashrc.d ]; then
    for file in $HOME/.dotfiles/bashrc.d/*.bash; do
        source $file
    done
fi

# load all files from .shell/rc.d directory
if [ -d $HOME/.dotfiles/rc.d ]; then
    for file in $HOME/.dotfiles/rc.d/*.sh; do
        source $file
    done
fi

