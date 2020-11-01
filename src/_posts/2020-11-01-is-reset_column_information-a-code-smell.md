---
layout: post
title: Is reset_column_information a code smell?
description: I've used `reset_column_information` in a lot of Ruby on Rails migrations, but it's frequently bitten me in the future. Here are my thoughts on if we should keep using it.
---

If you've worked with Ruby on Rails you've probably written a migration at some point that made use of the [`reset_column_information`](https://apidock.com/rails/ActiveRecord/ModelSchema/ClassMethods/reset_column_information) method. It's often used when you're intending to tweak some data around the table or column you've just modified.

## What's wrong with using it?

Migrations should only concern themselves with changing the structure of the database. Once they start add or removing data they will become super flaky, which will lead to a scenario where new developers are unable to run `bin/setup` (or `rails db:setup`) when setting up a project. Instead they'll be forced to use a database provided to them, often this will be a backup of production (which is a big data leak risk).

### What should you look out for?

Lets say you create a model called `JobLevel` & populate some data e.g:

```ruby
class CreateJobLevels < ActiveRecord::Migration[6.0]
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

The big "oh no" aspect of this, is you're now requiring every future developer to run this migration to populate the `job_levels` table in their database. If a developer doesn't run the migration, they'll have to find another way to add the data. Furthermore if the validation around the `name` field changes, the developer won't be able to run from a blank slate.

Here is another example which is quite common, but also problematic:

```ruby
class AddEnabledToJobLevels < ActiveRecord::Migration[6.0]
  def up
    add_column :job_levels, :enabled, :boolean, default: false, null: false
    JobLevel.reset_column_information
    JobLevel.update_all(enabled: true)
  end
end
```

In both examples, if the `JobLevel` model was renamed the migration would be unable to run again.

## What are the better approaches?

### SQL via `execute`

Using the `execute` method you can run arbitrary SQL during your migrations, e.g:

```ruby
class AddEnabledToJobLevels < ActiveRecord::Migration[6.0]
  def up
    add_column :job_levels, :enabled, :boolean, default: false, null: false
    execute('UPDATE job_levels SET enabled = TRUE')
  end
end
```

I really like this as they run with the constraints of the database at the point of the migration, instead of the current to the state of the app. So if I was to delete the `JobLevel` model, I'd still be able to re-run this migration in the future.

### Seeds!

One thing I've started to quite like doing is [during a release](https://github.com/Ruby-Starter-Kits/Docker-Rails-Template/blob/master/bin/release-tasks.sh) running migrations, then running the seeds. I like it because it means my development & production can both have their required data be setup in the same way, which encourages writing decent seeds e.g:

```ruby
# db/seeds.rb

# Seed all the job levels, if it exists it won't add a new one.
JobLevel.find_or_create_by!(name: 'manager')
```

### Why put unchanging data in the database?

To really get the [dev/prod parity](https://12factor.net/dev-prod-parity) down to zero, I've started thinking about if some bits of data belong in the database at all & if they'd be better of as Plain Old Ruby Objects e.g.

```ruby
JobLevel = Struct.new(:name, :enabled, keyword_init: true) do
  alias enabled? enabled

  def self.find(name)
    all.find { |job_level| job_level.name == name }
  end
  
  def self.all
    @all ||= [
      new(name: 'executive', enabled: true),
      new(name: 'manager', enabled: true),
    ]
  end
end
```

This approach is my favourite because instead of querying the database with a piece of unchanging data, we can just store it in memory. Plus it comes with a strong grantee that it'll be the same across all environments.

## So is reset_column_information a code smell?

I think so! I think it's an indicator of "The next few lines of code are going to bite you in the future", and in most cases there is a more reliable approach which can be taken.

While I don't think a Rubocop warning is suitable, I am going to try to avoid using it going forward.
