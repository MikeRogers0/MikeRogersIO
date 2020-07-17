---
layout: post
title: Naming colours in SCSS
description: Naming is tricky, here is how I do it.
---

TL;DR: Name them after the object or action they describe. So `danger` over `red`, or `create` instead of `green`.

Naming variables is notoriously difficult. A name which seemed good a few months ago, can easily become a nightmare.

## The terrible approach

I once picked up a project that had their SCSS variables setup like:

```scss
$red: #800000;
$blue: #ffffff;
$green: #28a745;
```

Those of you with eager eyes will notice the issue. At some point it was decided that all the elements that were blue, should actually be white...and instead of of improving the variable name across the codebase, this was just left like this.

Working on this codebase drove me a little crazy. Here are some better approaches.

## Primary, Secondary & Tertiary

One approach that is quite popular is:

```scss
$primary: #800000;
$secondary: #1531b7;
$tertiary: #28a745;
```

This encourages you to have a set number of colours, and name your buttons to be `.btn-primary`. However I've found this very difficult to communicate to clients (They wanted variations of primary, and secondary), and limiting for designers. Furthermore it's unclear as to when a element should use  `primary` or `secondary` for particular actions.

## Object or Action

My current preferred method is to base my colours around actions or objects, so for example:

```scss
$create: #800000;
$read: #1531b7;
$edit: #28a745;
$destroy: #28a745;
$alert: $destroy;
$notice: #e9dccd;
```

I like this approach as it requires less thinking when writing code as to which colour should be used. For example, if a button is going to create an object in the database, I use the `$create` colour, which can be mapped to a button called `.btn-create`.

### How I use this in my Rails + Bootstrap Projects

I'm a big fan of Rails + Bootstrap, and I like to setup the two to compliment each other. Once I've setup my Rails project, I normally setup a file called `app/assets/stylesheets/bootstrap/scss/_project-name-variables.scss` which is imported before I include the bootstrap SCSS, which starts with the following lines:

```scss
$create: #800000;
$read: #1531b7;
$edit: #28a745;
$destroy: #28a745;
$alert: $destroy;
$notice: #e9dccd;

$theme-colors: () !default;
$theme-colors: map-merge((
  "primary":      $create, // Primary is required to make bootstrap play nicely.
  "create":       $create,
  "read":         $read,
  "edit":         $edit,
  "destroy":      $destroy,
  "rails-alert":  $alert,
  "rails-notice": $notice,
), $theme-colors);
```

The super nice thing about this, is it'll output a bunch of elements with class names like `.btn-create`, `.btn-read` & `.alert-rails-alert`, which allow me to focus on coding instead of remembering what each class name translates to in a CRUD environment.

It also sets some formal rules like "If an action is going to create something, the user will click a `$create` coloured button", which is easier to communicate to users and colleagues.

### When you don't want class names

Having to add class names everywhere is also a bit of a pain, an approach I saw recently was:

```scss
form[method="post"] input[type=submit] {
  background: $create;
}

form[method="put"] input[type=submit],
form[method="patch"] input[type=submit] {
  background: $update;
}

form[method="delete"] input[type=submit] {
  background: $destroy;
}
```

I also really liked this approach, as it lets the developer just focus on creating plain forms & lets the designer implement rules based on HTTP verbs. 
