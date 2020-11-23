#!/bin/bash

# variables
git_files="gitconfig"

for git_file in $git_files; do
    echo "Moving .$git_file from ~ to $olddir"
    mv ~/.$git_file $olddir/
    echo "Creating symlink to $git_file in home directory."
    ln -s $dir/$config/$git_file ~/.$git_file
done