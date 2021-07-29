---
layout: post
title: Advanced Ruby on Rails Migrations
description: I always forget how to write these so off we go.
---

In most projects I've worked on, rails wasn't the only thing touching the database. I hate it & want to make it so if someone has direct access to the database it's hard for them to break it.

## Using null: false

```ruby
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :trainers do |t|
      t.string :email, null: false
      t.timestamps
    end
  end
end
```

## Unique validations

```ruby
class AddSpecialPowerToPokemons < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :special_power, :string, unique: true, where: "((special_power)::text <> ''::text)"
  end
end
```

## Check constraints

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

## Default Values

```ruby
class AddLevelToPokemon < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :level, :bigint, default: 1, null: false
	add_check_constraint "(level::bigint >= 1)"
  end
end
```


## Adding foreign keys

- rails doesn't add them by default for some reason.

```ruby
class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.references :user, null: false, foreign_key: true
	end
  end
end
```

## Comments:

- explain why a field is like it is

```ruby
class AddCaughtAtPokemon < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :caught_at, :datetime, comment: "Something Awesome"
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
