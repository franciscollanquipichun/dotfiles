#!/bin/bash

echo "Moving .vimrc from ~ to $olddir"
mv ~/.vimrc $olddir/
echo "Creating symlink to .vimrc in home directory."
ln -s $dir/$config/vimrc ~/.vimrc