---
layout: post
title: Advanced Ruby on Rails Migrations
description: I always forget how to write these so off we go.
---

The way Ruby on Rails handles migrations is really wonderful, when I compare it to other frameworks Rails always feels the most effortless to maintain.

You can actually add some pretty nifty things at the database level via the Rails Migrations. Mostly I just like to add extra constraints in, so if anyone accessed our database not via our Rails Application (E.g. someone connected directly to the production database) the data should remain valid.

## Requiring a field be present

Using the `null: false` argument, were can tell the database we definitely don't want this field to be nil. I think it'll accept a blank (e.g. "") value.

```ruby
class CreateTrainers < ActiveRecord::Migration[6.1]
  def change
    create_table :trainers do |t|
      t.string :email, null: false
      t.timestamps
    end
  end
end
```

## Unique or blank validations

The `unique: true` argument will require the field in the database be unique, but you can also allow the uniqueness rule to only be required when the field is filled in.

```ruby
class AddSpecialPowerToPokemons < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :special_power, :string, unique: true, where: "((special_power)::text <> ''::text)"
  end
end
```

## Check constraints

You can also add more complex rules around data validation using check constraints.

### Require a field when another is present

```ruby
class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.string :type, null: false

      t.string :grass_type
	  # When the type is "Species::Grass", the grass_type field can't be blank.
      t.check_constraint "(type::text != 'Species::Grass'::text) OR (type::text = 'Species::Grass'::text AND grass_type::text <> ''::text)"

      t.timestamps
    end
  end
end
```

### Field can't be less then zero (with default value)

```ruby
class AddLevelToPokemon < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :level, :bigint, default: 1, null: false
	add_check_constraint "(level::bigint >= 1)"
  end
end
```


## Adding foreign keys

By default Rails doesn't add foreign keys to relationships, which means it's really easy for other people accessing the database to remove things our model has a value for.

By adding this in, if someone tries to remove a row which still is being used by another row the database will not allow it.

```ruby
class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.references :user, null: false, foreign_key: true
	end
  end
end
```

## Join Tables

You can speed up your join tables with an index

```ruby
class CreateJoinTableForTrainersAndPokemons < ActiveRecord::Migration[6.1]
  def change
    create_join_table :pokemons, :trainers, column_options: {foreign_key: true, null: false}, table_name: :join_pokemons_trainers
    add_index :join_pokemons_trainers, [:pokemon_id, :trainer_id], name: :index_join_pokemons_trainers
  end
end
```

## Fixing data

Use Execute:

```ruby
class UpdateTypeNameOfPokemon < ActiveRecord::Migration[6.1]
  def up
    add_column :pokemons, :type, :string

    execute <<-SQL
      UPDATE pokemons SET type = 'Species::Grass' WHERE name = 'Bulbasaur';
    SQL
  end
end
```

## Summary

Often I'll add extra constraints to the columns on the database level which are paired with the [Active Model Validations](https://api.rubyonrails.org/classes/ActiveModel/Validations.html), the end result is nice.
