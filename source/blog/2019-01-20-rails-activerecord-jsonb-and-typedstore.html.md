---
layout: post
title: Rails ActiveRecord JSONB and TypedStore
categories:
 – blog
published: true
meta:
  description: Your can store JSON in your Database, but where should you use it?
  index: true
---

One of my favourite features of Rails ActiveRecord is its support for [storing JSON in your database](https://edgeguides.rubyonrails.org/active_record_postgresql.html#json-and-jsonb). Instead of having to store your JSON as string, then do some parsing when you pull it back out, you can declare a field as a `JSONB` type, and then rails will do the hard work for you. Plus when coupled with a Postgres database you'll get some neat performance wins.

## Where you can use it

Deciding when to use it requires a decent amount of discipline. It's very easy to normalise an entire database against a few objects, which long term will just giant objects being initialized regularly making your app a tad memory heavy.

As a rule of thumb, I try to pick relationships which are naturally common N+1s (when you'll be eager loading the relationships often), but the relationship is only used by a single model & could be namespaced onto the parent model. 

A gem I'm going to use in this post is [activerecord-typedstore](https://github.com/byroot/activerecord-typedstore) which gives these stores a nicer interface.

### A has_many relationship (Post tags)

I had an project where I had a `has_many` relationship which loaded up the tags which are associated to a blog post. The model looked like:

    class Post < ApplicationRecord
      has_many :tags
    end

These were often eager loaded on a lot of pages, so moving them to a JSONB store would fairly beneficial.

#### Approach with JSONB & ActiveRecord TypedStore

    class Post < ApplicationRecord
      typed_store :meta do |s|
        s.string :tags, array: true, default: [], null: false
      end
    end

    # Sample Usage
    post.meta.tags # Outputs ['some', 'tags']

I like this a lot, as it remove the need for eager loading (or an N+1), plus when I ran `post.inspect` the relationship of posts to tags was still there.

However, to query if a tag was associated to a post I had to run:

    User.where("meta @> ?", {tags: ['tag']}.to_json) }

Which is nice, but not the most obvious query to run.

### A belongs_to relationship (User preferences)

In the same project as above, I was storing users preferences in its own model like:

    class User < ApplicationRecord
      belongs_to :preferences
    end

    # Sample usage.
    user.preferences.send_weekly_digest? # Returns false
    user.preferences.dark_mode? # Returns false
    user.preferences.locale # Returns 'en'

It's a nice interface (albeit denormalised), but every time I wanted find out if a user had "Dark Mode" CSS enabled, it required loading an extra model which only stored data about users. Plus when I wanted to count the amount of users with "dark mode" enabled, I'd have to do a query like this:

    User.joins(:preferences).where(preferences: { dark_mode: true }).count

#### Approach I used before JSONB

Before JSONB, I would have stored these all against the `User` model under the "preferences" namespace field like:

    user.preferences_dark_mode? # Returns false

Which made counting the amount of users with "dark mode" enabled as just a matter of doing:

    User.where(preferences_dark_mode: true).count

This is fine, but a big drawback is that I ran `user.inspect` I saw a lot of extra information I usually didn't care about, plus it also required created a migration for each new preference.

#### Approach via JSONB & ActiveRecord TypedStore

To avoid polluting the main object, but still interact with them like a normal Model, I made use of the [activerecord-typedstore](https://github.com/byroot/activerecord-typedstore) gem, which allowed me to rewrite my model like:

    class User < ApplicationRecord
      # This method is available thanks to the activerecord-typedstore gem.
      typed_store :settings do |s|
        s.boolean :send_weekly_digest, default: false, null: false
        s.boolean :dark_mode, default: false, null: false
        s.boolean :locale, default: 'en', null: false
      end
    end

    # Sample usage
    user.preferences.send_weekly_digest? # Returns false
    user.preferences.dark_mode? # Returns false
    user.preferences.locale # Returns 'en'

This is a pretty nice interface, however the only big downside to doing this is to query the amount of users with "Dark Mode" requires writing a query like:

     User.where("preferences @> ?", { dark_mode: true }.to_json) }

Which is don't think is the clear query to write.

## Summary

Using the JSON field type against object is super handy for normalising data. Depending on your use case it can reduce the amount of time your app spends doing database queries, but it can also make your queries more complex.
