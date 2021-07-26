#!/bin/bash
function WriteLog() {
    echo $(date +%d%m%Y_%H%M%S): $1 >> $BACKUPPATHmysqlbackup.log
}

#check if 2 parameters are passed
# if [ $# -ne 2 ]
# then
#     WriteLog "Wrong or no parameters specified"
#     exit
# fi

#  check if mysql service is running
RESULT=$(systemctl status mysql | grep running)
BACKUPPATH="$1/sqlbackups/"
if [ ${#RESULT} -eq 0 ]
then
    WriteLog "MySQL is not running!"
else
    #WriteLog "MySQL is running"
    if [ ! -d $BACKUPPATH ]
    then
        WriteLog "Backup path is missing, creating"
        mkdir -p $BACKUPPATH
    fi
    #DBUSER_NAME=$1
    #DBUSER_PASS=$2
    #$(mysqldump Moodle -u $DBUSER_NAME -p$DBUSER_PASS > $BACKUPPATH$DBNAME_$CURDATETIME.sql)
    # To avoid exposing password, create file .my.cnf in your home directory:
    # [client] 
    # host='localhost'
    # user='username' 
    # password='password'
    CURDATETIME=$(date +%d%m%Y_%H%M)
    DBNAME="Moodle"
    $(mysqldump --defaults-extra-file="$1/.my.cnf" --no-tablespaces $DBNAME > $BACKUPPATH$DBNAME_$CURDATETIME.sql)
    if [ $? -ne 0 ]
    then
        WriteLog "Backup creation failed!"
        #Remove empty backup file
        rm $BACKUPPATH$DBNAME_$CURDATETIME.sql
    else
        WriteLog "File $BACKUPPATH$DBNAME_$CURDATETIME.sql saved"
    fi
fi
