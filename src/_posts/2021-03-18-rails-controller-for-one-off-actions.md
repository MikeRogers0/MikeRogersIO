---
layout: post
title: How To Rails Controller for one off actions
description: 
---

One programming problem I often come across is "What is the correct way to update a single field on a model", once you start adding concepts like Routes & Controllers to the question it opens you up to many potential solutions. I've never found a consistent solution between the code bases I've worked on, so I'm going to explore the options in this post.

## The premise



For example you have a model called Fruit which has the field `harvested_at` on it.

I have a model where I want to update a single column when a user clicks a button, so like "User clicks 'picked' link & it makes a boolean field true on the Fruit model" - Nothing to unusual, but I've seen three approaches to handling this:

# Potential solutions

1. In the FruitsController add an action called picked which toggles the field.
2. In the FruitsController, call the update method but only send the params to update the one field.
3. Create a Fruits::PicksController & cal the create method in here.

## 

## Sources


http://jeromedalbert.com/how-dhh-organizes-his-rails-controllers/
