#!/bin/bash
checkroot()
{
    if [ $UID -ne 0 ]
    then
        echo -e "Please, run this script as \e[1mroot.\e[0m"
        exit 1
    fi
}
checkuser()
{
    id -u $1 &>/dev/null
    if [ $? -ne 0 ]
    then
        echo -e "\e[31mERROR\e[0m: User $1 does not exist."
        exit 2
    fi
}

checkdirectory()
{
    if [ ! -d $1 ]
    then
        echo -e "\e[31mERROR\e[0m: Directory $1 does not exist."
        exit 3
    fi
}

case $1 in
    -h|--help)
    echo "Script to change the owner of files and subfolders within a given folder recursively"
    echo -e "Usage:\t`basename $0` <new_owner_name> <directory>"
    exit 0
esac

if [ $# -ne 2 ]
then
    echo "To get help run `basename $0` -h|--help"
    exit 0
else
    checkroot
    checkuser "$1"
    checkdirectory "$2"
    echo -e "Trying to set \e[1m$1\e[0m as new owner of \e[1m$2\e[0m directory."
    chown -v -R $1: $2 && echo -e "\e[32mChanging of owner complete successfully.\e[0m" || echo -e "\e[31mChanging of owner completed with error.\e[0m"
fi
