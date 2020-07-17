---
layout: post
title: How to use Twitter OAuth v1.1 with JavaScript/jQuery
description: A simple JavaScript patch for twitter API V1 retirement issue.
---
In March 2013 [Twitter plans to retire version 1](https://dev.twitter.com/blog/planning-for-api-v1-retirement) of their REST API, however it's replacement requires all requests to use OAuth signed headers. As a result if you're using JavaScript to pull in a twitter feed to show on your website, you might be  in for a spot of bother. However I've put together a little script which will allow you to remain using your JavaScript implementation, until you have time to move to the Twitter API 1.1 completely.

## The Code

Create a file called twitter-proxy.php and place it somewhere publicly accessible on your server.

```php
<?php

/**
 *  Usage:
 *  Send the URL you want to access URL encoded in the URL parameter, for example (This is with JS): 
 *  /twitter-proxy.php?url='+encodeURIComponent('statuses/user_timeline.json?screen_name=MikeRogers0&count=2')
*/

// The tokens, keys and secrets from the app you created at https://dev.twitter.com/apps
$config = array(
	'oauth_access_token' => 'token-here',
	'oauth_access_token_secret' => 'token-here',
	'consumer_key' => 'token-here',
	'consumer_secret' => 'token-here',
	'use_whitelist' => true, // If you want to only allow some requests to use this script.
	'base_url' => 'https://api.twitter.com/1.1/'
);

// Only allow certain requests to twitter. Stop randoms using your server as a proxy.
$whitelist = array(
	'statuses/user_timeline.json?screen_name=MikeRogers0&count=10&include_rts=false&exclude_replies=true'=>true
);

/*
* Ok, no more config should really be needed. Yay!
*/

// We'll get the URL from $_GET[]. Make sure the url is url encoded, for example encodeURIComponent('statuses/user_timeline.json?screen_name=MikeRogers0&count=10&include_rts=false&exclude_replies=true')
if(!isset($_GET['url'])){
	die('No URL set');
}

$url = $_GET['url'];


if($config['use_whitelist'] && !isset($whitelist[$url])){
	die('URL is not authorised');
}

// Figure out the URL parmaters
$url_parts = parse_url($url);
parse_str($url_parts['query'], $url_arguments);

$full_url = $config['base_url'].$url; // Url with the query on it.
$base_url = $config['base_url'].$url_parts['path']; // Url without the query.

/**
* Code below from http://stackoverflow.com/questions/12916539/simplest-php-example-retrieving-user-timeline-with-twitter-api-version-1-1 by Rivers 
* with a few modifications by Mike Rogers to support variables in the URL nicely
*/

function buildBaseString($baseURI, $method, $params) {
	$r = array();
	ksort($params);
	foreach($params as $key=>$value){
	$r[] = "$key=" . rawurlencode($value);
	}
	return $method."&" . rawurlencode($baseURI) . '&' . rawurlencode(implode('&', $r));
}

function buildAuthorizationHeader($oauth) {
	$r = 'Authorization: OAuth ';
	$values = array();
	foreach($oauth as $key=>$value)
	$values[] = "$key=\"" . rawurlencode($value) . "\"";
	$r .= implode(', ', $values);
	return $r;
}

// Set up the oauth Authorization array
$oauth = array(
	'oauth_consumer_key' => $config['consumer_key'],
	'oauth_nonce' => time(),
	'oauth_signature_method' => 'HMAC-SHA1',
	'oauth_token' => $config['oauth_access_token'],
	'oauth_timestamp' => time(),
	'oauth_version' => '1.0'
);
	
$base_info = buildBaseString($base_url, 'GET', array_merge($oauth, $url_arguments));
$composite_key = rawurlencode($config['consumer_secret']) . '&' . rawurlencode($config['oauth_access_token_secret']);
$oauth_signature = base64_encode(hash_hmac('sha1', $base_info, $composite_key, true));
$oauth['oauth_signature'] = $oauth_signature;

// Make Requests
$header = array(
	buildAuthorizationHeader($oauth), 
	'Expect:'
);
$options = array(
	CURLOPT_HTTPHEADER => $header,
	//CURLOPT_POSTFIELDS => $postfields,
	CURLOPT_HEADER => false,
	CURLOPT_URL => $full_url,
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_SSL_VERIFYPEER => false
);

$feed = curl_init();
curl_setopt_array($feed, $options);
$result = curl_exec($feed);
$info = curl_getinfo($feed);
curl_close($feed);

// Send suitable headers to the end user.
if(isset($info['content_type']) && isset($info['size_download'])){
	header('Content-Type: '.$info['content_type']);
	header('Content-Length: '.$info['size_download']);

}

echo($result);
?>
```

Be sure to update the $config variable with the tokens, keys and secrets provided by Twitter when you create an [app on their developer site](https://dev.twitter.com/apps) (this is free).

## Usage

Usage is pretty simple, instead of pointing your JavaScript XML request to Twitter just point it to the file you created instead. For example:

```javascript
/*
 * Before code
*/
$.getJSON('https://api.twitter.com/1/statuses/user_timeline.json?screen_name=MikeRogers0&count=2', function(d){
  // Some magic here
}

/*
 * Change to 
*/
$.getJSON('/twitter-proxy.php?url='+encodeURIComponent('statuses/user_timeline.json?screen_name=MikeRogers0&count=2'), function(d){
  // Some magic here
}
```
