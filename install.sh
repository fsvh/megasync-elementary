#!/bin/bash

read -p "Do you want to replace the default MEGAsync status icons with the new ones [Y/n]?is
This will install a patched version sni-qt thus replacing the default one!" yn

if [[ $yn =~ ^[Yy]$ ]] || [[ $yn == "" ]]; then
    
    echo "Adding the repository"
    sudo add-apt-repository --yes ppa:cybre/sni-qt-eplus

    
    echo "Updating package list"
    sudo apt-get -y update
    
    echo "Upgrading packages"
    sudo apt-get -y install sni-qt sni-qt:i386

    echo "Creating directory..."
    mkdir -p $HOME/.local/share/sni-qt/icons
    
    echo "Copying files to the directory..."
    cp ./icons/* $HOME/.local/share/sni-qt/icons/
    
    echo "Reverting MEGAsync application launchers..."
    newpath="Exec=$HOME/.bin/megasync-wrapper/megasync.sh"
    sudo sed -i "s|"$newpath"|Exec=megasync|g" /usr/share/applications/megasync.desktop
    sed -i "s|"$newpath"|Exec=megasync|g" $HOME/.config/autostart/megasync.desktop
    
    echo
    echo "You can now start MEGAsync from the applications menu and enjoy the new icons!"
fi
