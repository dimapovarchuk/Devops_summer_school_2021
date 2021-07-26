#!/usr/bin/env bash

#Requirements
#STEP 1
#Create backupuser in your mysql server and grant acces to databases you want to backup.
#CAUTION!!!!! This user can read all data from that DBs by design, so create it with access only from localhost.
#Mysql commands:
#CREATE USER 'backupuser'@'localhost' IDENTIFIED BY 'some password';
#GRANT SELECT, SHOW VIEW, TRIGGER ON db_name.* TO 'backupuser'@'localhost';
#STEP 2
#Create system variable "BACKUPUSER_PASS" that will contain password for mysql server. Bash command: export BACKUPUSER_PASS="some password". Do not forgent to add this variable to /etc/environment

#All dumps will be stored in /var/backup_db/


#Variables
RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'
BACKUPDIR="/var/backup_db"
TODAY=`date +%d%m%Y_%H%M`
#List databases you want to backup.
DATABASES=( moodle )



function checkPass {
    if [ -z "$BACKUPUSER_PASS" ]; then
        echo -e "${RED}Error!${NC} Password to MYSQL is empty ${RED}$2${NC}"
        exit 1
    else
        :
    fi
}


function checkDir {
    if [ -d "$1" ]; then
        :
    else
        mkdir /var/backup_db
    fi
}

function checkConnect {
    if mysql -u backupuser -p$BACKUPUSER_PASS -e ";" > /dev/null; then
        :
    else
        echo -e "${RED}Error!${NC} MYSQL password is invalid! ${RED}$2${NC}"
        exit 1
    fi
}


function checkMysql {
    if pgrep -x mysqld >/dev/null; then
        :
    else
        echo -e "${RED}Error!${NC} MYSQL daemon not running! ${RED}$2${NC}"
        exit 1
    fi
}


function runBackup {
    for DATABASE in "${DATABASES[@]}"
    do
        /bin/echo -e "${GREEN}Backup of database $DATABASE ${NC}"
        mysqldump -u backupuser -p$BACKUPUSER_PASS $DATABASE > $BACKUPDIR/${DATABASE}_$TODAY.sql
    done
}





checkMysql
checkPass
checkConnect
checkDir $BACKUPDIR
runBackup

exit 0
