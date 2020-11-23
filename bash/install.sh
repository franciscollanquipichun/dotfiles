#!/bin/bash

echo "Moving .bashrc from ~ to $olddir"
mv ~/.bashrc $olddir/
echo "Creating symlink to .bashrc in home directory."
ln -s $dir/$config/bashrc ~/.bashrc

echo "Moving .bash_profile from ~ to $olddir"
mv ~/.bash_profile $olddir/
echo "Creating symlink to .bashrc in home directory."
ln -s $dir/$config/bash_profile ~/.bash_profile