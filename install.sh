#!/bin/bash
############################
# install.sh
# This script run the setup installation
############################

# Variables

basepath=~/dotfiles               # dotfiles directory
olddir=~/.dotfiles_bkp            # old dotfiles backup directory
linkspath=$basepath/links         # symbolic links directories


# update from git repository
echo " Update files from source"
cd $basepath
git pull origin master --no-rebase
echo " `tput setaf 2`done`tput sgr0`"


# create dotfiles_old in homedir
echo " Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo " `tput setaf 2`done`tput sgr0`"


# change to the dotfiles directory
echo " Changing to the symbolic links directory: $linkspath"
cd $linkspath
echo " `tput setaf 2`done`tput sgr0`"

# Create symlinks
for dir in `ls -d */ | cut -f1 -d'/'`; do
    cd $dir
    for file in `ls`; do
        echo " Creating file backup: `tput bold`~/.$file >> $olddir`tput sgr0`"
        mv ~/.$file $olddir/
        echo " Creating symlink: `tput bold`~/.$file -> $linkspath/$dir/$file`tput sgr0`"
        ln -s $linkspath/$dir/$file ~/.$file
    done
    cd $linkspath
done
echo " `tput setaf 2`done`tput sgr0`"


# Install Homebrew
if test ! $(which brew)
then
  echo " Installing Homebrew"

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
  echo " `tput setaf 2`done`tput sgr0`"
fi


# Update homebrew
echo " Updating Homebrew and formulae"
    brew update
    brew upgrade
    brew cleanup

echo " `tput setaf 2`done`tput sgr0`"