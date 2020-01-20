---
layout: post
title: MySQL REPLACE function
tags:
- MySQL
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'An example of how to use the MySQL REPLACE function.'
  index: true
---
MySQL always surprises me in the sheer amount of stuff you can do in it. For example I recently found it has a bunch of [String Functions](https://dev.mysql.com/doc/refman/5.0/en/string-functions.html). The main one I found to be useful was the [REPLACE function](https://dev.mysql.com/doc/refman/5.0/en/string-functions.html#function_replace), which works like this:

```sql
REPLACE('Original String', 'Find This', 'Replace with this')

-- So it can be used like: --

SELECT REPLACE('My Original String', 'Original', 'Modified');
-- This will output: My Modified String --

-- So if you wanted to go through a full  table and replace a bunch of strings, you could use it like this: --

UPDATE `table_name` SET `field_name` = REPLACE(`field_name`, 'Find Me', 'Replace with Me');
```
