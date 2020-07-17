---
layout: post
title: PDO (PHP Data Objects) - Starter Guide
description: How to move off the deprecated mysql_* and start using PDO in PHP
---
It may surprise you to hear, that using the [mysql_connect()](http://php.net/manual/en/function.mysql-connect.php) function in PHP has recently be marked as "old hat" coding because it's slow in comparison with newer methods. A better alternative is [PDO (PHP Data Objects)](http://php.net/manual/en/book.pdo.php), a lightweight method for accessing databases. Here is a quick overview to help you get started with PDO.

## Reasons to use PDO

*   It's Fast - it talks to the database via a database specific PDO-driver.
*   It's Object Oriented - The methods within the class are the same for each database driver, so you can easily change your database driver without lots of extra coding.
*   It's Flexible-  You can easily change between such database drivers as PostgreSQL, MySQL or SQLite by pretty much just changing your construct statement.
*   It's Safer - PDO encourages you to bind parameters to your SQL query's, meaning that it's significantly less likely your website will suffer from a SQL injection based attack.

## Connecting to a Database

Connecting to a database is pretty simple. Here is how to connect to a MySQL Database.

```php
<?php
// Define the parameters
$host = 'localhost';
$dbname = 'my_database';
$user = 'mysql_username';
$pass = 'mysql_password';

try {
  // Call the PDO class.
  $db= new PDO('mysql:host='.$host.';dbname='.$dbname, $user, $pass);
} catch(PDOException $e) {
  // If something goes wrong, PDO throws an exception with a nice error message.
  echo $e->getMessage();
}

?>
```

## Doing A Query

Again, doing a query is just as simple as:

```php
<?php
$query = $db->query('SELECT * FROM `users` ORDER BY ID DESC;');
$result = $query->fetchAll(PDO::FETCH_ASSOC);

// $result will now contain an object of all the rows in the table 'Users'
?>
```

However, if you are using user variables which may cause a SQL Injection you should bind the parameter to the query (see next example).

## Binding a parameter to a query

```php
<?php
$query = $db->prepare('SELECT * FROM `users` WHERE `ID` = :ID: AND `email` = :email: ORDER BY ID DESC LIMIT 0,1;');
$query->execute(array(':ID:' => '3', ':email:' => 'me@email.com'));
$result = $query->fetchAll(PDO::FETCH_ASSOC);
?>
```

If you bind a parameter to a request, it will sterilize the input so that it will not cause a SQL Injection.

## Useful Resources

[PHP Manual: PHP Data Objects](http://php.net/manual/en/book.pdo.php) [Nettuts+: Why you Should be using PHP’s PDO for Database Access](http://net.tutsplus.com/tutorials/php/why-you-should-be-using-phps-pdo-for-database-access/)

## Update:

[As of PHP 5.4 the MySQL extension will be softly deprecated](http://news.php.net/php.internals/53799). This means you really should start using PDO ASAP!
