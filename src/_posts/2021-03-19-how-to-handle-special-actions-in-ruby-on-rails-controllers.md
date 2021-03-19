---
layout: post
title: How To Handle Special Actions In Ruby on Rails Controllers?
description: Should we add an custom action to a controller, or is using RESTful actions within a namespaced controller better? Let's compare the approaches!
---

Imagine you have a table called `crops` in your database, which contains a column named `harvested_at`. You'd like to allow a user to click a button to change the value of this button from `NULL` to the current time.

Pretty simple right? I'm pretty sure you can think of a few ways to do this. I'm going to focus on how you should approach this at the controller level, as I've never seen a _consistent solution_ to how the controllers should be setup.

In this post I'm going to go through the approaches you might discover in the wild and explore which option is the best. I'm going to write my examples in Ruby, but this is applicable to other languages.

## Approaches

### RESTful actions over custom actions

For this approach we'd create a nested controller which would extend from a parent controller, thus inheriting all the setup (e.g. setting the `@crop` value from the `id` parameter) for each action type.

```ruby
# app/controllers/crops/harvests_controller.rb
class Crops::HarvestsController < CropsController
  # CropsController has a before_action for setting @crop
  # for the update method which we inherit.

  # PATCH /crops/1/harvest
  def update
    @crop.touch(:harvested_at)

    redirect_to crop_path(@crop)
  end
end
```

I really like this approach as it keeps controllers fairly standardised. The other advantage is if we want to add any authorisation for this action, we could just add it & we'd have a high level of confidence it wouldn't affect any other user stories.

It's also how [Basecamp](http://jeromedalbert.com/how-dhh-organizes-his-rails-controllers/) & [Cookpad](https://github.com/cookpad/global-style-guides/tree/main/rails#prefer-rest-verbs) encourage writing their controllers, so that does give this approach a nice dash of credence.

The only downside to this approach is I often can't decide whether to use `create` or `update`. In the above example, I used `update` as I was updating the `@crop` model, however I could also technically be creating a "Crop Harvest" event so `create` would be more suitable.

### RESTful actions over custom actions (With concerns)

This is an alternative to the above approach, instead of inheriting from `CropsController`, you can inherit from `ApplicationController` and then use a concern to share the setup logic.

```ruby
# app/controllers/concerns/crop_scoped.rb
module CropScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_crop
  end

  private

  def set_crop
    @crop = Crop.find(params[:crop_id])
  end
end
```

```ruby
# app/controllers/crops/harvests_controller.rb
class Crops::HarvestsController < ApplicationController
  include CropScoped

  # PATCH /crops/1/harvest
  def update
    @crop.touch(:harvested_at)

    redirect_to crop_path(@crop)
  end
end
```

I saw [DHH Tweet about this approach](https://twitter.com/dhh/status/453188262002429952?lang=en) back in 2014. I've never worked with it in production, but I think it's a pretty cool approach.

The only drawback to this approach is you may need to explicitly set the resource parameter in the routes & it that could be a bit messy if the parameter is reused, but I do like it.

### Custom actions

This is a pretty common pattern and I've used it a few times in the past. Pretty much, you just add an extra method in your controller & hook it up to a route.

```ruby
# app/controllers/crops_controller.rb
class CropsController < ApplicationController
  before_action :set_crop, only: [:edit, :update, :delete, :destroy, :harvested]

  # PATCH /crops/1/harvested
  def harvested
    @crop.touch(:harvested_at)

    redirect_to crop_path(@crop)
  end
end
```

It's _ok, but not great_. What I've found is as more & more custom actions are added to your controller, the more you'll need to jump around the file to understand what is truly going on.

The end result of using this approach is you'll end up with lots of very long controllers, which will each behave very inconsistently in comparison to each other.

### Single Resource Controllers

In this approach, all your resources will only get basic CRUD actions & nothing else, all handled by a single controller for each resource.

So to set our `harvested_at` field, we'd submit a form with just the one field set as a parameter, then handle it using the same method we'd use for when the user is updating other fields via a different form.

```erb
<!-- app/views/crops/show.html.erb -->
<%= button_to "Harvest Crop", crop_path(@crop), method: :patch, form: { crop: { harvested_at: Time.zone.now } } %>
```

```ruby
# app/controllers/crops_controller.rb
class CropsController < ApplicationController
  # PATCH /crops/1
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

This is my least favourite approach, whenever I see it I usually just want to set fire to all the code. It's unspecific, which I think will lead to fragile code.

For example, if an exception occurred within my `update` method, it could be a large number of actions the user was performing which got them to that code. This would make debugging the exception a much slower experience. 

Furthermore, it could render the test code coverage metric unreliable. A developer may not realise our `harvested_at` use case doesn't have a test around it, but we could have 100% code coverage due to another loosely related test touching that line of code. This could lead to a lack of confidence in the application test suite.

It's also really easy for a developer to forget about adding authorisation, and a user to adjust the value of a field mischievously with this approach.

## Which one is best?

I really like the "RESTful actions over custom actions" approach the most. I'm pretty confident that it leads to code which is quite easy to reason about, and write specific tests around.
