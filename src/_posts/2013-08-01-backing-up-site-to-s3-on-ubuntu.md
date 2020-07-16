---
layout: post
title: How to backup a website to S3 on Ubuntu Server
published: true
categories:
 – blog
meta:
  description: 'A script breakdown of how to move backup your website (files and database) to Amazon S3 on Ubuntu Server'
  index: true
---
Regular backups of your website are super important. Below is the script I wrote to backup my site (files and databases) to S3.

## Prerequisites

There are a few things you need to install and configure before you start. 

* S3 Bucket - You need to setup a bucket on S3. To do this login to your AWS account, then navigate to the [S3 Storage](https://console.aws.amazon.com/s3/home?region=us-east-1) page, then create the bucket.
* Amazon Access Keys - You can find or create your access keys on the [AWS's Security Credentials](https://console.aws.amazon.com/iam/home?#security_credential) page. These are used to allow S3CMD to securely transfer files to your bucket.
* S3CMD - [S3CMD](http://s3tools.org/s3cmd) is a command line tool which is used to sync files with S3. You need to install this on your Ubuntu server then run: `s3cmd --configure`. 

## The backup script

Below is the backup script:

```bash
#!/bin/bash

## Email Variables
EMAILDATE=`date --date="today" +%y-%m-%d`
EMAIL="you@yourdomain.com"

SUBJECT="[servername] Backup Script Started! - "$EMAILDATE
EMAILMESSAGE="/tmp/emailmessage1.txt"
echo "Just to let you know that the backup script has started."> $EMAILMESSAGE
/bin/mail -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE

# Set up the variables
### The URI of the S3 bucket.
S3URI='s3://bucketname/'

### An array of directories you want to backup (I included a few configuration directories to).
DirsToBackup=(
'/var/www/vhosts/domain1.com/httpdocs'
'/var/www/vhosts/domain2.com/httpdocs'
'/var/www/vhosts/domain3.com/httpdocs'
)

### The databases you want to backup
DBsToBackup=(
'database1'
'database2'
'database3'
)

### The directory we're going to story our backups in on this server.
TmpBackupDir='/path/to/temp/s3backups/folder'


## The MySQL details
MySQLDetails[0]='localhost' # MySQL Host
MySQLDetails[1]='backup_user' # User
MySQLDetails[2]='yourstrongpassword' # Password


## The expiry dates of the backups
### Only store 0 days of backups on the server.
### Changed to 0 days to not fill the server with unnecessary backups
Expiry[0]=`date --date="today" +%y-%m-%d`

### Only store 2 weeks worth of backups on S3 
Expiry[1]=`date --date="2 weeks ago" +%y-%m-%d`

### Using ExpiryDayOfMonth to skip first day of the month when deleting so monthly backups are kept on s3
ExpiryDayOfMonth=`date --date="2 weeks ago" +%d`

### Today's date.
TodayDate=`date --date="today" +%y-%m-%d`

## Finally, setup the today specific variables.
Today_TmpBackupDir=$TmpBackupDir'/'$TodayDate


# Start backing up things.

## Check we can write to the backups directory
if [ -w "$TmpBackupDir" ]
then
  # Do nothing and move along.
    echo 'Found and is writable:  '$TmpBackupDir
else
    echo "Can't write to: "$TmpBackupDir
    exit
fi

## Make the backup directory (Also make it writable)
echo ''
echo 'Making Directory: '$Today_TmpBackupDir
mkdir $Today_TmpBackupDir
chmod 0777 $Today_TmpBackupDir

## GZip the directories and put them into the backups folder
echo ''
for i in "${DirsToBackup[@]}"
do
    filename='dir-'`echo $i | tr '/' '_'`'.tar.gz'
    echo 'Backing up '$i' to '$Today_TmpBackupDir'/'$filename
    tar -czpPf $Today_TmpBackupDir'/'$filename $i
done

## Backup the MySQL databases
echo ''
for i in "${DBsToBackup[@]}"
do
    filename='mysql-'$i'.sql'
    echo 'Dumping DB '$i' to '$Today_TmpBackupDir'/'$filename
    mysqldump -h "${MySQLDetails[0]}" -u "${MySQLDetails[1]}" -p"${MySQLDetails[2]}" $i > $Today_TmpBackupDir'/'$filename
    tar -czpPf $Today_TmpBackupDir'/'$filename'.tar.gz' $Today_TmpBackupDir'/'$filename
    rm -R $Today_TmpBackupDir'/'$filename
done

## Alert admin that backup complete, starting sync
SUBJECT="[servername] Backup Complete, Starting Sync! - "$EMAILDATE
EMAILMESSAGE="/tmp/emailmessage2.txt"
echo "Just to let you know that the backup script has finished and we're starting sync to s3 now."> $EMAILMESSAGE
/bin/mail -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE

## Sending new files to S3
echo ''
echo 'Syncing '$Today_TmpBackupDir' to '$S3URI$TodayDate'/'
s3cmd put --recursive $Today_TmpBackupDir $S3URI
if [ $? -ne 0 ]; then
    SUBJECT="s3cmd put failed on [servername]"
    EMAILMESSAGE="/tmp/emailmessage3.txt"
        echo "Just to let you know that the s3cmd put of '$Today_TmpBackupDir' failed."> $EMAILMESSAGE
        echo "You should check things out immediately." >>$EMAILMESSAGE
    /bin/mail -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE
fi

# Cleanup.
echo ''
echo 'Removing local expired backup: '$TmpBackupDir'/'${Expiry[0]}
rm -R $TmpBackupDir'/'${Expiry[0]}

if [ "$ExpiryDayOfMonth" != '01' ]; then
    echo 'Removing remote expired backup: '$S3URI${Expiry[1]}'/'
    s3cmd del $S3URI${Expiry[1]}'/' --recursive
else
    echo 'No need to remove backup on the 1st'
fi

echo 'Making '$Today_TmpBackupDir' permissions 0755'
chmod 0755 $Today_TmpBackupDir

echo 'All Done! Yay! (",)'

## Notify admin that the script has finished
SUBJECT="[servername] S3 Sync Complete! - "$EMAILDATE
EMAILMESSAGE="/tmp/emailmessage4.txt"
echo "Just to let you know that the s3 sync has now completed."> $EMAILMESSAGE
/bin/mail -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE


## Email Report of What Exists on S3 in Today's Folder
exec 1>'/tmp/s3report.txt'
s3cmd ls s3://bucketname/$TodayDate/

SUBJECT="S3 Backup Report of [servername]: "$TodayDate
EMAILMESSAGE="/tmp/s3report.txt"
/bin/mail -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE
```

In the next subsections I've explained a few key aspects of the script you need to worry about.

### Variables

For the most part, you should only need to edit the variables in the first 20 lines of the script. Here is an overview of what they all mean.

* `EMAIL` - The email address to send backup reports to.
* `S3URI` - This is the URI of your S3 bucket. This can be found in the AWS S3 management page and normally has the format `s3://bucket-name/`.
* `DirsToBackup` - This is an array of the directories you want to backup. 
* `DBsToBackup` - The names of the databases you want to backup.
* `TmpBackupDir` - The directory where your backups will be held. This should be writeable by the user who runs the cron (If you're not sure, just chmod it to 0777). 
* `MySQLDetails` - This is your host, user and password details used to connect to MySQL.

#### MySQL User

It's really important to create a MySQL user which has only the minimal privileges required to run its task. In the `mysqldump` command the user only needs the privileges to select and lock tables. Here is the SQL to create a user with the required  privileges:

```sql
CREATE USER 'backup_user'@'localhost' IDENTIFIED BY 'SomeSecurePassword!';
GRANT SELECT, LOCK TABLES ON *.* TO 'backup_user'@'localhost';
```


## Setting up a cron
To make this script run every day at 3am, just add the following to your [crontab](http://www.adminschoice.com/crontab-quick-reference/):

```
0 3    * * *   bash    /path/to/your/backup-to-s3.sh
```

## Updates 

6th January 2013: A big thanks to [David Behan](https://twitter.com/davidbehan) for updating the backup script, adding lots of helpful additional functionality.
