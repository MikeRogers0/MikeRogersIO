---
layout: post
title: Elegant Rails Scopes
categories:
 – blog
published: true
meta:
  description: 
  index: true
---

Rails Activerecord does a lot of magic when writing 

It's 

When writing Activerecord queries, it's super important to avoid writing any raw SQL. They'll b

## More or greater than

class User < ApplicationRecord
  scope :created_after_last_, -> { where(trial_expires_at: [Time.zone.now..Float::INFINITY]) }
end
User.trial_expires_at >= some.time

## Between two values

class User < ApplicationRecord
  scope :created_after_last_, -> { where(trial_expires_at: [Time.zone.now..Float::INFINITY]) }
end
User.trial_expires_at >= some.time

## Passing Varibles

class User < ApplicationRecord
  scope :created_after, -> (time){ where(trial_expires_at: [time..Float::INFINITY]) }
end
User.trial_expires_at >= some.time

## Where NOT NULL

class User < ApplicationRecord
  scope :created_after, -> { where.not(confirmed_at: nil) }
end
User.trial_expires_at >= some.time
