#!/bin/bash
$username=$1; $directory=$2
getent passwd $1 > /dev/null 2&>1
if [ $? -eq 0 ]; then
    echo "Yes the user exists and you can change owner!"
else
    echo "No, the user does not exist, to change owner forbidden!"
fi
for directory in /home/user/DevOps-Summer-School-2021*
do
    if [ -d "$directory" ]
    then
        sudo chown $1:$1 -R $2
    fi
done