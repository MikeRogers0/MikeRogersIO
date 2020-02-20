---
layout: post
title: How to Rails Scaffolding Magic
categories:
 – blog
published: true
meta:
  description: How to stop doing the same darn thing.
  index: true
---

One under documented aspects of Ruby on Rails is how to improve your development process by overriding the scaffolding templates. Doing this allows you to have greater control over the files that are created when you run `rails generate scaffold`.

## Creating a better form

## Creating custom views

## Where are things from

One of the less documented aspects of Ruby on Rails is how to speed up your development process by overriding the scaffolding templates. By this I mean the files which are created when you run `rails generate scaffold`.



```
lib/templates/erb/controller/view.html.erb.tt
lib/templates/erb/scaffold/_form.html.erb
```

## References

https://github.com/rails/rails/tree/b2eb1d1c55a59fee1e6c4cba7030d8ceb524267c/railties/lib/rails/generators - Where all the generators live
