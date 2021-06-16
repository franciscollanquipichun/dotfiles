#!/bin/bash
############################
# install.sh
# This script run the setup installation
############################

# Variables

basepath=~/dotfiles               # dotfiles directory
olddir=~/.dotfiles_bkp            # old dotfiles backup directory
linkspath=$basepath/links         # symbolic links directories

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
bold=`tput bold`
nc=`tput sgr0` # No color

# update from git repository
echo "${bold}Update files from source${nc}"
cd $basepath
git pull origin main --no-rebase

# create dotfiles_old in homedir
if [[ ! -d "$olddir" ]]
then
    echo "${bold}Creating ${blue}$olddir${bold} for backup of any existing dotfiles in ${blue}~${nc}"
    output=$(mkdir -p $olddir 2>&1)
    if [ -n "$output" ]; then
        echo "${yellow}${output}${nc}"
    fi
fi


# change to the dotfiles directory
echo "${bold}Changing to the symbolic links directory: ${blue}$linkspath${nc}"
cd $linkspath


# Create symlinks
echo "${bold}Creating symlinks${nc}"
echo "·"
for dir in `ls -d */ | cut -f1 -d'/'`; do
    cd $dir
    echo "├── $dir"
    for file in `ls`; do
        echo "│   ├── $file"
        echo "│   │    > Creating file backup: ${blue}~/.$file >> $olddir${nc}"
        output=$(mv ~/.$file $olddir/ 2>&1)
        if [ -n "$output" ]; then
            echo "│   │      ${yellow}${output}${nc}"
        fi
        echo "│   │    > Creating symlink: ${blue}~/.$file -> $linkspath/$dir/$file${nc}"
        output=$(ln -s $linkspath/$dir/$file ~/.$file 2>&1)
        if [ -n "$output" ]; then
            echo "│   │      ${yellow}${output}${nc}"
        fi
    done
    cd $linkspath
done


# Install Homebrew 🍺
if test ! $(which brew)
then
  echo "${bold}Installing 🍺 Homebrew${nc}"

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
  echo " ${green}done${nc}"
fi

# Update homebrew
echo "${bold}Updating 🍺 Homebrew and formulae${nc}"
brew update
brew upgrade
brew cleanup

# Install Oh My ZSH!
if test ! -d ~/.oh-my-zsh
then
  echo "${bold}Installing Oh My ZSH!${nc}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo " ${green}done${nc}"
fi

# Install powerlevel10k
if test ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
then
  echo "${bold}Installing powerlevel10k${nc}"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  echo " ${green}done${nc}"
fi

# Install JetBrainsMono Font
if test "$(uname)" = "Darwin"
then
  if test ! -f ~/Library/Fonts/JetBrainsMono-Regular.ttf
  then
    echo "${bold}Installing JetBrains Mono${nc}"
    brew tap homebrew/cask-fonts
    brew install --cask font-jetbrains-mono
    echo " ${green}done${nc}"
  fi  
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
  if test ! -f ~/.local/share/fonts/fonts/ttf/JetBrainsMono-Regular.ttf
  then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
  echo " ${green}done${nc}"
  fi
fi
