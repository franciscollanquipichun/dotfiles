#!/bin/bash
############################
# install.sh
# This script run the setup installation
############################

# Variables

basepath=~/dotfiles               # dotfiles directory
olddir=~/.dotfiles_bkp            # old dotfiles backup directory
linkspath=$basepath/links         # symbolic links directories

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "`tput setaf 2`done`tput sgr0`"

# change to the dotfiles directory
echo "Changing to the symbolic links directory: $linkspath"
cd $linkspath
echo "`tput setaf 2`done`tput sgr0`"

for dir in `ls -d */ | cut -f1 -d'/'`; do
    cd $dir
    for file in `ls`; do
        echo "Moving .$file from ~ to $olddir"
        mv ~/.$file $olddir/
        echo "Creating symlink to `tput bold`$linkspath/$dir/$file`tput sgr0` in home directory."
        ln -s $linkspath/$dir/$file ~/.$file
    done
    cd $linkspath
done
echo "`tput setaf 2`done`tput sgr0`"
