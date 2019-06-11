---
layout: post
title: Patterns to avoid when using JSON columns
categories:
 – blog
published: true
meta:
  description: Rails supporting JSON field type is a great, but can screw you right over. 
  index: true
---

Rails 5.2 introduced support for [JSON field types](https://edgeguides.rubyonrails.org/active_record_postgresql.html#json-and-jsonb), which is super awesome. It allows a really nice way of storing blobs of JSON against an object in your database. But while they're convenient, they can end up being a double edged sword and can lead to a headache if you aren't careful.

## Patterns to avoid

### Merging JSON data

Imagine a scenario where you'd like to store some adhoc data against a model, so you merge the new data over the old data e.g:


    model = Model.find(params[:id])

    # Set some values:
    new_values = { important_value: :value }

    # But in another HTTP request, at the same time you're running:
    new_values = { other_important: :value }

    model.jsonb_field.merge!(new_values)
    model.save
    model.jsonb_field['important_value'] # Could be empty or out of date.

This is a really risky pattern, because in a multi-threaded environments (e.g. two HTTP requests updating the same object around the same time) you'll run the risk of losing data. This is because from the point `.find` is called, the model may have been updated from another request.

A better approach is to store data you _really want to be there_ in its own field. Most frameworks are smart enough to only update the fields you've changed (Rails included).

### A replacement for columns

A pattern I've seen pop up, is the JSON columns being used as an alternative to putting things in their own columns, e.g:

    user.settings = {
      dark_mode: true,
      send_weekly_digest: true,
      locale: 'en'
    }

This is usually done in an attempt to normalise data to avoid N+1 queries, which is good & gems such as [activerecord-typedstore](https://github.com/byroot/activerecord-typedstore) make this process fairly manageable.

However, I've found querying against this data can be unreliable, e.g.

     User.where("settings @> ?", { dark_mode: true }.to_json) }

If the event the User model hadn't been saved since a new field in the JSON was added, this could return in incorrect number.

A better approach would be to add a migration for a field called `settings_dark_mode` with a default of `true` or `false`. While visually not as lovely, it does make for more reliable querying.
