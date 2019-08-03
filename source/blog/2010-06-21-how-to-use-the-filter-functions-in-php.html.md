---
layout: post
title: How to use the Filter Functions in PHP
tags:
- PHP
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'An example of how to use PHP filter functions to validate and sanitise strings.'
  index: true
---
When I started learning PHP (Back in the PHP4 days) validating data was always a pain (for me at least). Most of the resources available cited the [POSIX functions](http://uk3.php.net/manual/en/ref.regex.php) as the most effective way of validating an email address or URL.

Thankfully since then, the PHP community has embraced the [PCRE functions](http://uk3.php.net/manual/en/ref.pcre.php) which are more efficient and are Perl-compatible. However the downside to PCRE (and POSIX for that matter) is that you need to know [regular expressions](http://en.wikipedia.org/wiki/Regular_expression), which for a newbie to learn can feel like walking through a minefield.

Recently though the [Filter Functions](http://www.php.net/manual/en/ref.filter.php) have become a very popular method to validate data. This is due to their small learning curve.

## How to use the Filter Functions

In this example (Using the [filter_var()](http://www.php.net/manual/en/function.filter-var.php) function) the filter function takes the data you input (For example: email@example.com) and will return either the data (if it's valid) or false (if the data is not valid).

```php
<?php
// Filter an Email Address
var_dump(filter_var('email@example.com', FILTER_VALIDATE_EMAIL)); // Returns: string(17) "email@example.com"

// This is a fake email being filtered.
var_dump(filter_var('fake_mail.com', FILTER_VALIDATE_EMAIL)); // Returns: bool(false)

var_dump(filter_var('ema(i)l@example.com', FILTER_SANITIZE_EMAIL )); // Returns: string(17) "email@example.com"

// Filter a URL
var_dump(filter_var('example.com', FILTER_VALIDATE_URL)); // Returns: bool(false)

// Filter a URL
var_dump(filter_var('http://example.com', FILTER_VALIDATE_URL)); // Returns: string(18) "http://example.com"

// Example usage
$email = 'email@example.com'; // or something submitted from a form.
if(!filter_var($email, FILTER_VALIDATE_EMAIL)){ // If this returns false
	die('The email you send is invalid.');
}
?>
```

A handful of the useful [available filters](http://www.php.net/manual/en/filter.filters.php) are:

* `FILTER_SANITIZE_STRING` - Removes HTML tags and possibly unwanted characters.
* `FILTER_SANITIZE_EMAIL` - Removes unwanted characters from an email address.
* `FILTER_SANITIZE_URL` - Removes unwanted characters from a URL.
* `FILTER_SANITIZE_NUMBER_INT` - Returns only digits,  + and -.
* `FILTER_VALIDATE_INT` - If data is not an integer it will return false.
* `FILTER_VALIDATE_URL` - If data is not a URL it will return false.
* `FILTER_VALIDATE_EMAIL` - If data is not an email it will return false.
* `FILTER_VALIDATE_IP` - If data is not an IP it will return false.
