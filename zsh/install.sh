#!/bin/bash

echo "Moving .zshrc from ~ to $olddir"
mv ~/.zshrc $olddir/
echo "Creating symlink to .zshrc in home directory."
ln -s $dir/$config/zshrc ~/.zshrc

echo "Moving .zprofile from ~ to $olddir"
mv ~/.zprofile $olddir/
echo "Creating symlink to .zprofile in home directory."
ln -s $dir/$config/zprofile ~/.zprofile

# Powerlevel10k configuration
echo "Moving .p10k.zsh from ~ to $olddir"
mv ~/.p10k.zsh $olddir/
echo "Creating symlink to .p10k.zsh in home directory."
ln -s $dir/$config/p10k.zsh ~/.p10k.zsh