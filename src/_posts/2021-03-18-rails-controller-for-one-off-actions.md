---
layout: post
title: How To Rails Controller for one off actions
description: 
---

Imagine you have a table called `crops` in your database, which contains the column `harvested_at`. You want to change the value of this column from `NULL` to the current time when a user clicks a button.

While this is a pretty simple problem to solve, I've never seen a _consistent_ solution to how the Controllers should be setup.

In this post I'm going to go through the approaches you might discover in the wild and explore which option is the best. I'm going to write my examples in Rails, but this is applicable to other languages also.

## Approaches

### RESTful actions over custom actions

[I found it here](https://github.com/cookpad/global-style-guides/tree/main/rails#prefer-rest-verbs)

### Custom actions in the resource controller

This is the worst

```ruby
class CropsController < ApplicationController
  def harvested
    @crop.touch(:harvested_at)
  end
end
```

### Single Controller

In this approach, all your resources will only get their CRUD actions & nothing else. So to set our `harvested_at` field, we'd submit a form with just the one field set as a parameter.

```erb
<%= button_to "Harvest Crop", crop_path(@crop), method: :patch, form: { crop: { harvested_at: Time.zone.now } } %>
```

```ruby
class CropsController < ApplicationController
  def update
    if @crop.update(crop_params)
	  redirect_to crop_path(@crop)
	else
	  render :edit
	end
  end

  private

  def crop_params
    params.require(:crop).permit(:name, :description, :harvested_at)
  end
end
```

This is my least favourite approach to see.

## Which one is best


## 

Imagine you want to build a page, where there is a button that changes the value 


For example you have a model called Fruit which has the field `harvested_at` on it.

I have a model where I want to update a single column when a user clicks a button, so like "User clicks 'picked' link & it makes a boolean field true on the Fruit model" - Nothing to unusual, but I've seen three approaches to handling this:

# Potential solutions

1. In the FruitsController add an action called picked which toggles the field.
2. In the FruitsController, call the update method but only send the params to update the one field.
3. Create a Fruits::PicksController & cal the create method in here.

## 

## Sources


http://jeromedalbert.com/how-dhh-organizes-his-rails-controllers/
https://github.com/cookpad/global-style-guides/tree/main/rails#prefer-rest-verbs
