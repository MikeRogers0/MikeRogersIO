---
layout: post
title: Decrease loading times via .htaccess
description: A trick to reduce load times with .htaccess (gzipping)
---
Here is a really nifty trick I've been using for a while to decrease the time a page takes to load. Add the following lines of code to your .htaccess file:

```
FileETag none # Turn off eTags
<IfModule mod_expires.c> # Check that the expires module has been installed
  ExpiresActive On
  ExpiresDefault "access plus 10 years"
  ExpiresByType image/gif "access plus 10 years"
  ExpiresByType image/jpeg "access plus 10 years"
  ExpiresByType image/png "access plus 10 years"
  ExpiresByType text/css "access plus 10 years"
  ExpiresByType text/html "access plus 1 seconds"
  ExpiresByType text/javascript "access plus 10 years"
  ExpiresByType application/x-unknown-content-type "access plus 10 years"
  ExpiresByType application/x-javascript "access plus 10 years"
</IfModule>
<IfModule mod_gzip.c> # check if gZip support has been installed
  mod_gzip_on Yes
  mod_gzip_dechunk Yes
  mod_gzip_item_include file .(html?|txt|css|js|php|pl)$
  mod_gzip_item_include handler ^cgi-script$
  mod_gzip_item_include mime ^text.*
  mod_gzip_item_include mime ^application/x-javascript.*
  mod_gzip_item_exclude mime ^image.*
  mod_gzip_item_exclude rspheader ^Content-Encoding:.*gzip.*
</IfModule>
```

This quick and easy method tells the user to cache files which are unlikely to change for 10 years (feel free to change the amount of time) and HTML for 1 second. It also turns off eTags.

_Update:_ I also added a another piece of code I use which turns on Gzip, which reduces the amount of bandwidth required to transfer a file.
