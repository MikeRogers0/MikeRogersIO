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

For this approach we create a nested controller which could extend from the parent controller, thus inheriting all the setup (e.g. setting `@crop`) for each action type.

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

I really like this approach as keeps controller slim & if we want to add any authorisation, it gives me a high level of confidence it'll only affect user story. Plus it's how [DHH](http://jeromedalbert.com/how-dhh-organizes-his-rails-controllers/) & [Cookpad](https://github.com/cookpad/global-style-guides/tree/main/rails#prefer-rest-verbs) encourage writing their controllers.

The only downside to this approach is I often can't decide whether to use `create` or `update`. In the above example, I'm technically creating a "Crop Harvest" 

### RESTful actions over custom actions (With concerns)

This is an alternative to the above approach, instead of inheriting from `CropsController`, you can inherit from `ApplicationController` & use a concern to share the setup logic.

```ruby
# app/controllers/concerns/crop_scoped.rb
module CropScoped
  extend ActiveSupport::Concern
  
  included do
    before_action :set_crop
  end
  
  private

  def set_crop
    @crop = Crop.find(params[:cropid])
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

### Custom actions

This is normally what I see and I've used it a few times, where you just add an extra method in your controller & hook it up to your routes.

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

It's fine, but as you start adding more & more things to your controller, it'll bigger & harder to organise! Furthermore the `before_action` can be pretty out of control once you start adding lots of methods.

### Single Resource Controllers

In this approach, all your resources will only get the standard CRUD actions & nothing else. So to set our `harvested_at` field, we'd submit a form with just the one field set as a parameter, then handle it using the same method we'd use for when the user is updating other fields via a different form.

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

This is my least favourite approach, it makes the validation for if the value can be set tricker & a user could adjust the value being set by tampering with the HTML.

## Which one is best

I think "RESTful actions over custom actions" is the right approach.
