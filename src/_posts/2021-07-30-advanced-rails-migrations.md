---
layout: post
title: Advanced Ruby on Rails Migrations
description: I've always liked the way Rails handles migrations, here are some best practises I picked up recently.
---

The way Ruby on Rails handles migrations is really wonderful, when I compare it to other frameworks Rails always feels the most effortless to maintain.

You can actually add some pretty nifty things at the database level via the Rails Migrations. Mostly I just like to add extra constraints in, so if anyone accessed our database not via our Rails Application (E.g. someone connected directly to the production database) the data should remain valid.

## Requiring a field be present

Using the `null: false` argument, were can tell the database we definitely don't want this field to be nil. I think it'll accept a blank (e.g. "") value.

```ruby
class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :email, null: false
      t.timestamps
    end
  end
end
```

## Unique or blank validations

The `unique: true` argument will require the field in the database be unique, but you can also allow the uniqueness rule to only be required when the field is filled in.

```ruby
class AddSpecialSkillToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :special_skill, :string, unique: true, where: "((special_skill)::text <> ''::text)"
  end
end
```

## Check constraints

You can also add more complex rules around data validation using check constraints.

### Require a field when another is present

```ruby
class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :speciality, null: false

      t.string :grass_type
	  # When the type is "Species::Grass", the grass_type field can't be blank.
      t.check_constraint "(speciality::text != 'grass'::text) OR (speciality::text = 'grass'::text AND grass_type::text <> ''::text)"

      t.timestamps
    end
  end
end
```

### Field can't be less then zero (with default value)

By using a check constraint you can even check if a field is present, and is an attempt to be valid.

```ruby
class AddLevelToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :level, :bigint, default: 1, null: false
	add_check_constraint "(level::bigint >= 1)"
  end
end
```

## Adding foreign keys

By default Rails doesn't add foreign keys to relationships, which means it's really easy for other people accessing the database to remove things our model has a value for.

By adding this in, if someone tries to remove a row which still is being used by another row the database will not allow it.

```ruby
class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.references :user, null: false, foreign_key: true
	end
  end
end
```

## Join Tables

You can speed up your join tables with an index:

```ruby
class CreateJoinTableForPlayersAndTeams < ActiveRecord::Migration[6.1]
  def change
    create_join_table :players, :teams, column_options: {foreign_key: true, null: false}, table_name: :join_players_teams
    add_index :join_players_teams, [:player_id, :team_id], name: :index_join_players_teams
  end
end
```

## Fixing data

You might be tempted to reference models in your migrations, but it's not unheard of models to change. To make your migrations more future proof they should only worry about the database at the point they're running.

You can best achieve this by using execute & SQL.

```ruby
class UpdateTypeOfPlayers < ActiveRecord::Migration[6.1]
  def up
    add_column :players, :type, :string

    execute <<-SQL
      UPDATE players SET type = 'grass' WHERE name = 'Ted Lasso';
    SQL
  end
end
```

## Summary

Often I'll add extra constraints to the columns on the database level which are paired with the [Active Model Validations](https://api.rubyonrails.org/classes/ActiveModel/Validations.html), the end result is nice.
