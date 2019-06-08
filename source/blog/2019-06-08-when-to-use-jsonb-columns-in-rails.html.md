---
layout: post
title: Code Smells when using JSONB fields
categories:
 – blog
published: true
meta:
  description: PostgreSQL's JSONB field type is a great, but can screw you right over. 
  index: true
---

Rails 5.2 introduced support for PostgreSQL's JSONB field type, which is super awesome. It allows a really nice way of storing blobs of JSON in your database, that are pretty nice to work with. But while they're convenient, they can end up being a double edged sword and screw your codebase over if you aren't careful.

## Patterns to avoid

### Merging new data into your JSONB Field

It is super tempting to have code like:

    model.jsonb_field.merge!({new: 'values'})
    model.save

However this is a terrible idea. In the event you have two requests updating that field at the same time, you run the risk of losing data.

### A catch all for hard to categorise data

    customer.data = {
      statistics: {}
      device: {}
      vendor_name: { id: 'some-id' }
    }

This is very tempting to do as it saves the developer writing a migration.

### An alternative to namespacing

One pattern I've seen pop up, is the JSONB fields being used as an alternative to putting things in their own columns, e.g:

    user.settings = {
      dark_mode: true,
      send_weekly_digest: true,
      locale: 'en'
    }

The main temptation for doing is it allows for adding values, without a migration & with gems such as [activerecord-typedstore](https://github.com/byroot/activerecord-typedstore) this can be easy to work with.

However, I've found querying against this data unreliable, e.g.

     User.where("settings @> ?", { dark_mode: true }.to_json) }

If the event the User model hadn't been saved since a new field in the JSON was added, this could return in incorrect number.

A better approach would be to add a migration for a field called `settings_dark_mode`.

## So what should you store in a JSONB field?
