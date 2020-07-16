---
layout: post
title: Geeklet for monitoring server ping
description: A geektool geeklet code sample that shows server status and ping.
---

I've been using [Geektool](http://projects.tynsoe.org/en/geektool/) for a while now, it's a super handy way to display useful information on my desktop. One geeklet I've found to be useful displays the status and ping of my VPS.

{% img src: /uploads/2014/01/18/uptime-monitor-geeklet.png width: 168 alt: "Server name and its ping" %}

## Geeklet code
Here is the code you need to stick in the command box.

```php
#!/usr/bin/php
<?php
# Array of the servers you want to ping.
$servers = array('mikerogers.io', 'google.com', 'downserver.come');

# PingDomain() from http://stackoverflow.com/a/9843251/445724
function pingDomain($domain){
    $start_time = microtime(true);
    $file      = @fsockopen ($domain, 80, $errno, $errstr, 10);
    $end_time  = microtime(true);

    if ($file){ # We connected ok.
        fclose($file);
        return floor(($end_time - $start_time) * 1000);
    }
    return false;
}

foreach ($servers as $server){
  $pingTime = pingDomain($server);
  if($pingTime){ # it's online
		echo "\033[0;32m".$server." (".$pingTime."ms)\033[0;254;176;19m";
  } else {
		echo "\033[0;31m".$server." (Offline)\033[0;254;176;19m";
  }
	echo "\n";
}
?>
```

To modify the websites being pinged, just edit the $servers array on line 4.
