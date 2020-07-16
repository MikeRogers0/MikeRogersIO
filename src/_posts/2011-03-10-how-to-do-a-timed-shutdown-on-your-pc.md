---
layout: post
title: How to do a timed shutdown on your PC
description: How to do a timed shutdown on Windows 7 and 8
---
Recently I've stumbled upon a really neat technique to listening to [Spotify](http://www.spotify.com/) while I'm heading off to bed, then not have to get up to turn my music off once I'm dropping off.

Firstly, set up a playlist in Spotify which will help you relax. Once you have done this step, open up command line ([cmd.exe](http://www.microsoft.com/resources/documentation/windows/xp/all/proddocs/en-us/cmd.mspx?mfr=true)) and type the following:

```bash
shutdown -s -f -t 900
```

## Code Breakdown

The above command will shutdown your PC in 900 seconds. Let me quickly break down how this command works:

* `shutdown` indicates you want to run [shutdown.exe](http://technet.microsoft.com/en-us/library/bb491003.aspx)
* `-s` is a flag saying you want to shutdown your PC
* `-f` is a flag stating you want to force shutdown, so your PC will not hang around waiting for applications to close while shutting down
* `-t` is a flag which indicates you want a timed shutdown
* `900` means the amount of seconds until the shutdown occurs. In this case 900 seconds, or 15 minutes.

Once this is command has been run you should see an information bubble (Like below) stating when the shutdown will occur.

{% img src: /uploads/2011/03/information_bubble.png width: 317 alt: "An information bubble on windows 7 showing the computer is about to shutdown." %}

## How to abort

You may also want to abort your shutdown, in that case just put the following code into your command line:

```bash
shutdown -a
```

The `-a` flag stands for "Abort a system shutdown".
