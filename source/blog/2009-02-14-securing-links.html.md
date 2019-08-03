---
layout: post
title: Securing Links
tags:
- click tracker
- Coding
- PHP
- secure links
- Security
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'A simple link cloaker example with PHP'
  index: true
---
Have you ever wanted to secure links on your website (for example hide the real source of a file)? Here is a quick and easy way to do this.

## The Code

```php
<?php # File created on 11th February 2009 by Mike Rogers (http://www.fullondesign.co.uk/). 

## Start defining constants ## 
define(RUN_ERRORS, TRUE); // Do you want the script to display errors? TRUE = yes you do.
define(redirect_or_echo, 'redirect'); // Do you want to redirect the user to another website, or just echo the other other webpages' content. 'rediect' will redirect, 'echo' will return the web pages constents. I recommend redirect.
## End defining constants ##

/* Start the link codes. The code is the ?code=123 part of the URL. The array should be fotmatted like:
$link['code'] = 'http://URL';
You may find it easier to do this with MySQL or including this as a seperate file. Too many links could lower performance, but for a small website just trying to cloak a few links this is good :)
*/
$link['1'] = 'http://www.site.com/';

// Start the system.
function external_url($url){
	if($return = @file_get_contents($url)){
		return $return;
	}elseif(function_exists("curl_init")){
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_TIMEOUT, 10);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
		$return = curl_exec($ch);
		curl_close($ch);
		return $return;
	}elseif($return = @implode("", @file($url))){
		return $return;
	} else {
		return NULL;
	}
}


// Checks if the code is a number
if(is_numeric($_GET['code']) && is_array($link)){
	if(isset($link[$_GET['code']])){
		if(redirect_or_echo === 'redirect'){
			header('location: '.$link[$_GET['code']]);
		} elseif(redirect_or_echo === 'echo'){
			echo external_url($link[$_GET['code']]);
		}else{
			if(RUN_ERRORS === TRUE){
				echo 'Sorry, an internal error has occoured.';	
			}
		}
	} else {
		if(RUN_ERRORS === TRUE){
			echo 'Sorry, the code you have provided is incorrect.';	
		}
	}
}else{
	if(RUN_ERRORS === TRUE){
		echo 'Sorry, the code you have provided is incorrect.';	
	}
}
/*
You are free to share, modify and use this code for commerical uses. Please give a link back (to http://www.fullondesign.co.uk/ ) if you can, but you don't have you.

I claim no liability in this code, you use it at your own risk.
*/
?>
```
