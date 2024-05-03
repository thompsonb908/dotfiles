#!/bin/bash
###############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
###############################


#### Variables

dir=~/dotfiles              # dotfiles directory
olddir=~/dotfiles_old       # old dotfiles backup
files="bash_profile bashrc gitconfig tmux.conf zlogin zshrc" # list of files and folders to symlink

####

# create an old dotfiles directory
echo -n "Creating $olddir for backup of existing files in ~ ..."
mkdir -p $olddir
echo "done"

cd $dir


# move any files in homedir to olddir, create symlinks from homedir to dotfiles dir
for file in $files; do
    sym_path=`eval "readlink ~/.$file"`
    subpath=`echo $dir`

    if [[ -n "$sym_path" && $sym_path == "$subpath"* ]]; then
        echo "$file already linked -> skip"
        continue
    fi
    if [[ -e ~/.$file ]]; then
        echo "Moving .$file to $old_dir"
        mv ~/.$file $olddir/.$file
    fi
    echo "Creating symlink to .$file in home directory"
    ln -s $dir/$file ~/.$file
done

echo -n "Clone bin directory ..."
#./install_bin.sh
echo "Done"

# Extra installations:

# Tmux
which -s tmux
if [[ $? != 0 ]]; then
    sudo apt install tmux
fi


install_zsh()
{
    # Test is zsh is installed
    if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
        # clone oh-my-zsh repo if not present
        if [[ ! -d $dir/oh-my-zsh/ ]]; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        fi
        # set default shell to zsh
        if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
            chsh -s $(which zsh)
        fi
    else
        # if zsh isn't installed, get the platform of the current machine
        platform=$(uname);
        # if platform is linuz run apt to install zsh
        if [[ $platform == "Linux" ]]; then
            if [[ -f /etc/redhat-release ]]; then
                sudo yum install zsh
                install_zsh
            fi
            if [[ -f /etc/debian_version ]]; then
                sudo apt install zsh
                install_zsh
            fi
        else
            echo "not linux, please install zsh manually"
        fi
    fi
}

#install_zsh
