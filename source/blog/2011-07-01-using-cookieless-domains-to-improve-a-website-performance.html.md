---
layout: post
title: Using cookieless domains to improve a website performance
tags:
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'A demo of how to set up a cookieless domain'
  index: true
---
Fast loading times are a really important factor when it comes to website ranking, so it's important to remove as much unnecessary data as possible. A good method to do this is via cookieless domains.

Cookieless domains are (as the name suggests) are domains, in which the user will not send cookies (Which can add quite a few kilobytes to a request). For example, say I want a user to load a static image it would be silly of them to also send me the cookie data. Luckily they are super easy to set up.

## Set up a sub-domain

Firstly, set up a subdomain on your website. For example static.yourdomain.com would be suitable, but it's really up to you. Now point the domain to a path where you will keep your static files (Such as images and CSS files). For Full On Design, I set up files.fullondesign.co.uk.

## Stop cookies being set site wide

Next, make sure your website does not set website wide cookies. The fastest way to do this is by amending the .htaccess file and adding a [CookieDomain Directive](http://httpd.apache.org/docs/2.2/mod/mod_usertrack.html#CookieDomain). For example:

{% gist 2942004 .htaccess %}

Alternatively in PHP's [setcookie()](http://php.net/manual/en/function.setcookie.php) function, I could just use something like:

{% gist 2942004 setCookie.php %}

The key point to note is that the domain parameter is set to www.fullondesign.co.uk, not .fullondesign.co.uk. Thus the cookies will only be sent when the subdomain is www.fullondesign.co.uk.

Now start linking up to files in that directory and your pretty much done.

## Setting up cookieless domains in Wordpress

Wordpress has a few neat built in functions to make this process easier. If you use wordpress pop the following code (just before the "That's all, stop editing! Happy blogging." comment) into your config.php file (amend as required):

{% gist 2942004 wp-cookie-domain.php %}

You can also change the uploads URL of your Wordpress install to point to your cookieless domain. In the config.php file add the following(amend as required).:

{% gist 2942004 wp-content-url.php %}

## Useful Resources

I've barely touched on the topic of cookieless domains aside from just saying "They making your website load faster", here a two website which go a little more in depth.

*   [Google: Minimize request overhead](http://code.google.com/speed/page-speed/docs/request.html)
*   [Ravelrumba: Serving Static Content from a Cookieless Domain](http://www.ravelrumba.com/blog/static-cookieless-domain/)
