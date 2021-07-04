#!/usr/bin/env bash
$username=$1 $directory=$2
output=$(getent passwd $username)
if [ $username? -gt 0 ]; then
    if [ -d $directory ]; then
      sudo chmod $username:$username -R $directory
    fi
else
    echo "No, the user does not exist, to change owner forbidden, or directory $directory doesn't exist!"
fi

