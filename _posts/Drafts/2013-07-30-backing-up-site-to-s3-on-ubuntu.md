---
layout: post
title: How to backup a website to S3 on Ubuntu
published: true
meta:
  description: 'A script breakdown of how to move backup your website (files and database) to Amazon S3 on Ubuntu'
  index: true
---
Regular backups of your website are super important. Here is the breakdown of the script I wrote to backup my site and its database to Amazon S3.

## Prerequisites
There are a few things you need to install and configure before you start. 

### S3 Bucket
You need to setup a bucket on an S3. To do this login to your AWS account, naviate to the [S3 Storage](https://console.aws.amazon.com/s3/home?region=us-east-1) page, then create the bucket.

### Amazon Access Keys
You can find or create your access keys on [AWS's Security Credentials](https://console.aws.amazon.com/iam/home?#security_credential) page. These are used to allow S3CMD to send files to your bucket.

### S3CMD
[S3CMD](http://s3tools.org/s3cmd) is a command line tool which is used to sync files with S3. You need to install this on your unbuntu server then run: `s3cmd --configure`. 

## The backup script
Below is the backup script

	Code here, like a thug

In the next subsections I've broken down each part of the script.

### Variables
What the variable at the top of the script do...

### Gzip the files
how to make a tar ball.

### Dump the database
Make a read-only user, spit out the data.

### Send to S3
bah...

### Cleanup
Removing old stuff

## Setting up a cron
To make this script run every day, just run it as a cronjob, to do this:...