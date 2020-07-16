---
layout: post
title: How to validate an email address with PHP
description: A method of validating emails in PHP without regex.
---
Validating an email address is a great way to reduce spam on your website, but there are several methods to do it. You could use a messy regex approach or alternatively you could also use PHP built in functions, it's really up to you. Here is the function I use:

```php
<?php
function validEmail($email){
  // Check the formatting is correct
  if(filter_var($email, FILTER_VALIDATE_EMAIL) === false){
    return FALSE;
  }

  // Next check the domain is real.
  $domain = explode("@", $email, 2);
  return checkdnsrr($domain[1]); // returns TRUE/FALSE;
}

// Example
validEmail('real@hotmail.com'); // Returns TRUE
validEmail('fake@fakedomain.com'); // Returns FALSE
?>
```
