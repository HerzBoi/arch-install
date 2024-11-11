#! bin/bash

#check if yay installed

#install pacman 

#isstall yay 

# go through packages file
    #run pacman

    # run yay 

yayInstalled="false"
notinstalled=()

yayCheck()
{
    yay --version
    if [ $? -eq 0 ]; then
        yayInstalled="true"
    else
        echo "yay not installed"
        exit
    fi
}

pacmanInstall
{
    if pacman -Qs "$package" > dev/null; then
        sudo pacman -S --noconfirm "$package"
    
    else
        notinstalled+=('$package')
}

yayInstall
{
    if yay -Qs"$package" > dev/null; then
        yay -S --noconfirm "$package"
    else
        notinstalled+=('$package')
}

fileReader
{
    while IFS= read -r package; do
        if [[-z "$package" || "$package" =~ ^# ]]; then
            continue
        fi

        if [[ "$package" == "pacman"]]; then
            pacman="true"
            yay="false"
            continue
        fi

        if [["$package" == "yay"]]; then
            pacman="false"
            yay="true"
            continue
        fi

        if $pacman; then
            pacmanInstall
        elif $yay; then
            yayInstall
        else
            echo "bruh u fucked up"
            exit

        done <packages.txt
        yay -Yc	
}

main
{
    # updates system
    sudo pacman -Syu
}