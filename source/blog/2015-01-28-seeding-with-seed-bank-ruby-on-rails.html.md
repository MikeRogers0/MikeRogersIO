---
layout: post
title: Seeding with Seedbank
categories:
 – blog
published: true
meta:
  description: A video explaining how to use Seedbank in a rails project.
  index: true
tags: 
 - Rails
 - Seedbank
video_length: 13
---

{% youtube lEmuj3bVrW0 %}

In this tutorial I explain [Seedbank](https://github.com/james2m/seedbank), a gem that I use regularly that helps keep the seeds in your project organised.

## Seeding class

To help keep the seed files as clean as possible, I've made a class that stops seeds being added twice and also outputs to the user what has been added to the database:

```ruby
class Seeds
  def self.add model, attrs
    object = model.find_or_initialize_by(attrs)

    if object.new_record? && object.save
      puts "#{object}"
    end
  end
end
```

Here is how to implement the class in your seeds:

```ruby
after :farms do
  puts 'Adding Users:'

  farm = Farm.find_by name: 'McCain'
  Seeds.add User, full_name: 'Mr McCain', is_manager: true, farm: farm
end
```

You can find all the code behind this tutorial in the [GitHub Repo](https://github.com/MikeRogers0/GenericApp/tree/refactoring-seeds).
