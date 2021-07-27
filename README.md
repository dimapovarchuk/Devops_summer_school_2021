Bash (Task #1)

Title: Create scenario to change the owner of files and folders
Parameters: 
$1 username
$2 directory
Requirements:
$1 - should be existing user in your OS (in your script the checking block should be present)
$2 - should be only the directory (also need to be checked in your script)

  
  Prepare Environment for deploying LMS Moodle (LAMP Stack)

Requirements
1 server (2 GiB RAM, 1 vCPU, 10 GiB)


Task 2.1
Install MySQL 5.7.x (Mariia DB)
https://www.digitalocean.com/community/tutorials/mysql-ubuntu-18-04-ru
Create user on mysql server for specific db (which will be user for LMS Moodle)
Create database for LMS Moodle
Assign grant permission on database which created on step 3 for user which was created on step 2 (example present in pptx file)
Create bash script for making dump of database and write this dump to the file with name like following: moodle_<currentdate_currenttime>.sql
 

        
        
