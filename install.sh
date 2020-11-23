#!/bin/bash
############################
# install.sh
# This script run the setup installation
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/.dotfiles_bkp            # old dotfiles backup directory
configs="git vim zsh bash"        # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

export dir
export olddir

for config in $configs; do
    export config
    ./$config/install.sh
done