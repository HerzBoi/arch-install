#!/bin/bash

#check if yay installed

#install pacman packages

#install yay packages

# go through packages file
    #run pacman

    # run yay 

yayInstalled="false"
notinstalled=()
installedPackages=()

yayCheck()
{
    yay --version
    if [ $? -eq 0 ]; then
        yayInstalled="true"
    else
        echo "yay not installed"
        exit 1
    fi
}

pacmanInstall()
{
    echo "Installing AUR packages"

    if pacman -Qs "$package" > dev/null; then
        sudo pacman -S --noconfirm "$package"

        installedPackages+=("$package")

    else
        notinstalled+=("$package")
}

yayInstall()
{
    echo "Installing AUR packages"

    if yay -Qs "$package" > dev/null; then
        yay -S --noconfirm "$package"

        installedPackages+=("$package")

    else
        notinstalled+=("$package")
}

fileReader()
{
    pacman=false
    yay=false

    # Check if packages.txt exists
    if [ ! -f packages.txt ]; then
        echo "Error: packages.txt file not found!"
        exit 1
    fi

    # Reads through package.txt
    while IFS= read -r package; do
        if [[ -z "$package" || "$package" =~ ^# ]]; then
            continue
        fi

        if [[ "$package" == "_pacman" ]]; then
            pacman="true"
            yay="false"
            continue
        fi

        if [[ "$package" == "_yay" ]]; then
            pacman="false"
            yay="true"
            continue
        fi

        if $pacman; then
            pacmanInstall "$package"
        elif $yay; then
            yayInstall "$package"
        else
            echo "installer type error"
            exit 1
        fi

    done <packages.txt
        
}

logger()
{ 
    logFile="log_$(date +%H_%M_%S_%d_%m_%Y).txt"
    touch "$logFile"
    
    if [ ${#installedPackages[@]} -gt 0 ]; then
        echo "Installed" >> "$logFile"
        for pkg in "${installedPackages[@]}"; do
            echo "- $pkg"
        done
    else
        echo "No packages were installed."
    fi
    if [ ${#notinstalled[@]} -gt 0 ]; then
        echo "Not Installed" >> "$logFile"
        for pack in "${notinstalled[@]}"; do 
            echo "$pack" >> "$logFile"
        done
    else
        echo "All packages were installed successfully."
    fi

    echo "All packages have been logged to $logFile"
   
}

cleanUp()
{
    echo "clean up started"

    yay -Yc --noconfirm
    sudo pacman -Sc --noconfirm

    echo "cleaning up done"
}

# TODO download graphics drivers if -g argument passed

main()
{
    # Update system with error handling
    echo "Updating system..."
    sudo pacman -Syu --noconfirm
    if [ $? -ne 0 ]; then
        echo "Error: System update failed!"
        exit 1
    fi

    # Check if yay is installed
    yayCheck

    # Process the packages file
    fileReader

    # cleans up cache
    cleanUp

    # Logs installed and not installed files
    logger
}