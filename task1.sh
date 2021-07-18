#!/usr/bin/env bash
$username=$1,
$directory=$2,
output=$(getent passwd $username)
if [ $? -eq 0 ]; then
    if [ -d $directory ]; then
      sudo chown $1:$1 -R $2
    fi
else
    echo "No, the user does not exist, to change owner forbidden, or directory $2 doesn't exist!"
fi

