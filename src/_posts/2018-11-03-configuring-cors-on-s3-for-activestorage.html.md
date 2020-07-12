---
layout: post
title: Configuring CORS on S3 for ActiveStorage
categories:
 – blog
published: true
meta:
  description: The AWS S3 CORS configuration to allow Direct Upload for ActiveStorage.
  index: true
---

If you haven't tried Rails new ActiveStorage feature, do it! It's bloody lovely to work with! However, recently I ran into a "OMFG why isn't this working" moment while uploading files with Direct Upload to AWS S3 via ActiveStorage in Ruby On Rails.

## The Error

After submitting the form, it got stuck in it's disabled "I am submitting" state.

The error in my browser console looked a little like this:

```
Access to XMLHttpRequest at 'https://my-s3-bucket.s3.eu-west-2.amazonaws.com/z8kvinUXFQFPy…Signature=3652b50…' from origin 'https://example.com' has been blocked by CORS policy: Response to preflight request doesn't pass access control check: No 'Access-Control-Allow-Origin' header is present on the requested resource.
```

## The Fix

The fix took me a bit of searching to get this totally right, but on the AWS website navigate to your S3 bucket, go to permissions, then "CORS Configuration". The URL should look something like:

```
https://s3.console.aws.amazon.com/s3/buckets/YOUR_BUCKET_NAME/?region=us-east-1&tab=permissions
```

From here, adjust your configuration to look like:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <AllowedHeader>Authorization</AllowedHeader>
</CORSRule>
<CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>PUT</AllowedMethod>
    <AllowedMethod>POST</AllowedMethod>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <AllowedHeader>*</AllowedHeader>
</CORSRule>
</CORSConfiguration>
```
