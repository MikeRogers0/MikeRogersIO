---
layout: post
title: Elegant Rails 5 Scopes
categories:
 – blog
published: true
meta:
  description: Stop writing raw SQL, instead let Active Record handle that for you.
  index: true
---

Rails is great, with each update it's making working with it even more enjoyable. Active Record in particular has added a bunch of little improvements that help avoid writing raw SQL (Which can be risky when combined them with the [joins](https://apidock.com/rails/ActiveRecord/QueryMethods/joins) & [includes](https://apidock.com/rails/ActiveRecord/QueryMethods/includes) methods). Here are a few of my favourites:

## More/Less or equal to

If you pass an array into the [where](https://apidock.com/rails/ActiveRecord/QueryMethods/where) method with the `Float::INFINITY` value, it'll output a `more/less or equal to` SQL equivalent.

    class User < ApplicationRecord
      # Active trial: Where trial_expires_at is a time in the future
      # >= can be mixed with DateTimes.
      scope :active_trial, -> { where(trial_expires_at: [Time.zone.now..Float::INFINITY]) }

      # Has normal amount of cats: Anything less then 4.
      # <= can't be used for DateTimes.
      scope :has_normal_amount_of_cats, -> { where(cats: [Float::INFINITY..4]) }
    end

    puts User.active_trial.to_sql
    # SELECT "users".* FROM "users" WHERE ("users"."trial_expires_at" >= '2017-10-03 14:26:30.806410')

    puts User.has_normal_amount_of_cats.to_sql
    # SELECT "users".* FROM "users" WHERE ("users"."cats" <= 4)


## Between two values

Passing two integers into into the method will output SQL for "Give me rows where is field is between these values".

    class User < ApplicationRecord
      scope :expired_trial, -> { where(trial_expires_at: [Time.at(0)..Time.zone.now]) }
      scope :millennials, -> { where(dob_year: [1985..2000]) }
    end

    puts User.expired_trial.to_sql
    # SELECT "users".* FROM "users" WHERE ("users"."trial_expires_at" BETWEEN '1970-01-01 00:00:00' AND '2017-10-03 14:51:43.216361')

    puts User.millennials.to_sql
    # SELECT "users".* FROM "users" WHERE ("users"."dob_year" BETWEEN 1985 AND 2000)


## Passing Variables

You can also pass variables into your scope.

    class User < ApplicationRecord
      scope :with_dob_year, -> (year){ where(dob_year: year) }
    end

    puts User.with_dob_year(2001).to_sql
    # SELECT "users".* FROM "users" WHERE "users"."dob_year" = 2001


## Where NOT NULL

The [not](https://apidock.com/rails/ActiveRecord/QueryMethods/WhereChain/not) method is useful for when you require a field to not match a value.

    class User < ApplicationRecord
      scope :confirmed, -> { where.not(confirmed_at: nil) }
    end

    puts User.confirmed.to_sql
    # SELECT "users".* FROM "users" WHERE ("users"."confirmed_at" IS NOT NULL)

