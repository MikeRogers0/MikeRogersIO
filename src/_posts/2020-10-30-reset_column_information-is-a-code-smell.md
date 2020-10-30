---
layout: post
title: Is Model.reset_column_information a code smell?
description: 
---

If you've worked with Ruby on Rails you've probably written a migration at some point that made use of the [`Model.reset_column_information`](https://apidock.com/rails/ActiveRecord/ModelSchema/ClassMethods/reset_column_information) method. It's often used when you're intending to tweak some data around the table or column you've just modified.

## What's wrong with using it?

Migrations should only concern themselves with changing the structure of the database. Once they start changing the data they will become super flaky in the future, which will lead to a scenario where the only way to get a working development database is to download a copy of somewhere else (Which is really bad).

For example, let's say you create a model called `JobLevel` & populate some data e.g:

```ruby
class CreateJobLevels < ActiveRecord::Migration[5.0]
  def up
    create_table :job_levels do |t|
      t.string :name
    end

    JobLevel.reset_column_information
    JobLevel.create(name: 'executive')
    JobLevel.create(name: 'manager')
  end
end
```

This is terrible. You now require that migration to be ran to allow 

If you were to ever rename the `JobLevel` model, this migration would be unable to run in the future. Plus

Firstly if you renamed the model or changed the `name` field (e.g. added a new validation around is saying `manager` isn't a valid option), this

Or alternatively, we were looking to add a new field:

```ruby
class AddEnabledToJobLevels < ActiveRecord::Migration[5.0]
  def up
    add_column :job_levels, :enabled, :boolean
    JobLevel.reset_column_information
    JobLevel.update_all(enabled: true)
  end
end
```

The problem is, if you wanted rename the model to be called `JobRole` the older migration would break because the `JobLevel` model doesn't exist any more.

## What are the better approaches?

### Default values

A quick win is to just set a default value

### SQL

### Seeds!
