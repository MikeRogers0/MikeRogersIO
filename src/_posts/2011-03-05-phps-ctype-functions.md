---
layout: post
title: PHP's Ctype Functions
tags:
- PHP
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'PHPs Ctype functions which validate strings quickly without regex.'
  index: true
---
A few days ago I was researching methods of validating alphanumeric strings and I was shown PHPs [Ctype Functions](http://www.php.net/manual/en/ref.ctype.php) by [Sebastian Roming](http://www.sebastianroming.de/).

In a nutshell they are a group of PHP functions why can be used to check strings to see if they are alphanumeric, numeric etc without using regex (So they are fast!). The key thing to remember is that they return TRUE or FALSE, unlike filter_var which returns FALSE or the string.

Here is the code example:

```php
<?php
// Check if input is alphanumeric (letters and numbers)
ctype_alnum('abcdef1234'); // This returns TRUE
ctype_alnum('£%^&ab2'); // This on the otherhand returns FALSE

// check if input is alpha (letters)
ctype_alpha('dssfsdf'); // returns TRUE
ctype_alpha('12345dssfsdf'); // Returns FALSE
?>
```
It also contains functions to check for just numeric strings, uppercase strings and lowercase strings.

```php
<?php
// Check if the input is numeric
ctype_digit('1234'); // TRUE
ctype_digit('1as2d34f'); // FALSE

// Uppercase
ctype_upper('HELLO'); // TRUE
ctype_upper('hElLo'); // FALSE

// Lowercase
ctype_lower('hello'); // TRUE
ctype_lower('HeLLo'); // FALSE
?>
```

Handy right?
