---
layout: post
title: PDO (PHP Data Objects) - Starter Guide
tags:
- PHP
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'How to move off the deprecated mysql_* and start using PDO in PHP'
  index: true
---
It may surprise you to hear, that using the [mysql_connect()](http://php.net/manual/en/function.mysql-connect.php) function in PHP has recently be marked as "old hat" coding because it's slow in comparison with newer methods. A better alternative is [PDO (PHP Data Objects)](http://php.net/manual/en/book.pdo.php), a lightweight method for accessing databases. Here is a quick overview to help you get started with PDO.

## Reasons to use PDO

*   It's Fast - it talks to the database via a database specific PDO-driver.
*   It's Object Oriented - The methods within the class are the same for each database driver, so you can easily change your database driver without lots of extra coding.
*   It's Flexible-  You can easily change between such database drivers as PostgreSQL, MySQL or SQLite by pretty much just changing your construct statement.
*   It's Safer - PDO encourages you to bind parameters to your SQL query's, meaning that it's significantly less likely your website will suffer from a SQL injection based attack.

## Connecting to a Database

Connecting to a database is pretty simple. Here is how to connect to a MySQL Database.

{% gist 2941987 connecting-to-database.php %}

## Doing A Query

Again, doing a query is just as simple as:

{% gist 2941987 query.php %}

However, if you are using user variables which may cause a SQL Injection you should bind the parameter to the query (see next example).

## Binding a parameter to a query

{% gist 2941987 binding.php %}

If you bind a parameter to a request, it will sterilize the input so that it will not cause a SQL Injection.

## Useful Resources

[PHP Manual: PHP Data Objects](http://php.net/manual/en/book.pdo.php) [Nettuts+: Why you Should be using PHP’s PDO for Database Access](http://net.tutsplus.com/tutorials/php/why-you-should-be-using-phps-pdo-for-database-access/)

## Update:

[As of PHP 5.4 the MySQL extension will be softly deprecated](http://news.php.net/php.internals/53799). This means you really should start using PDO ASAP!
