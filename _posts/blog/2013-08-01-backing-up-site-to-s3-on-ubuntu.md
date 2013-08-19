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

{% gist 6127154 backup-to-s3.sh %}

In the next subsections I've explained a few key aspects of the script you need to worry about.

### Variables
For the most part, you should only need to edit the variables in the first 20 lines of the script. Here is an overview of what they all mean.

* S3URI - This is the URI of your S3 bucket. This can be found in the AWS S3 management page and normally has the format `s3://bucket-name/`.
* DirsToBackup - This is an array of the directories you want to backup. 
* DBsToBackup - The names of the databases you want to backup.
* TmpBackupDir - The directory where your backups will be held. This should be writeable by the user who runs the cron (If you're not sure, just chmod it to 0777). 
* MySQLDetails - This is your host, user and password details used to connect to MySQL.

#### MySQL User
It's really important to create a MySQL user which has only the minimal privileges required to run its task. In the `mysqldump` command the user only needs the privileges to select and lock tables. Here is the SQL to create a user with the required  privileges:

{% gist 6127154 createBackupUser.sql %}


## Setting up a cron
To make this script run every day at 3am, just add the following to your crontab:

{% gist 6127154 cronExample %}