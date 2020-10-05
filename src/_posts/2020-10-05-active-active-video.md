---
layout: post
title: Admin Panels In Rails 6 (Video Series)
description: I really like using ActiveAdmin for building admin panels within my  Rails Apps. I've put together a quick video series to introduce people to it.
---

One of my most reached for gems when working with Ruby on Rails is [ActiveAdmin](https://github.com/activeadmin/activeadmin). It's a framework for building administration sections on top of your Ruby on Rails apps.

What really has made me enjoy using ActiveAdmin, is that it quietly encourages following the Rails conventions like ending a datetime field with `_at`. It even introduces concepts like Decorators & Pundit in a "If you do it right, it'll be super quick to build" experience.

I'd even argue, if you are building a back office Rails App it could be worthwhile to build the entire thing within ActiveAdmin & forget about writing anything remotely custom.

## Videos & Source Code

* [Part 1 (Set up ActiveAdmin)](https://www.youtube.com/watch?v=QBzOZxRVfs8)
* [Part 2 (Resources, Filters & Scopes)](https://www.youtube.com/watch?v=5tCWXSaTfUI)
* [Part 3 (Custom Actions & Decorators)](https://www.youtube.com/watch?v=ZuF6M3s-hq0)
* [Final Source code](https://github.com/MikeRogers0/ActiveAdmin-Demo)

## Set up ActiveAdmin

Setting ActiveAdmin is pretty well documented on their repo (And might have changed since I wrote this). The only prerequisite I don't expect to change is requiring [Devise](https://github.com/heartcombo/devise) be setup to handle authorisation.

In the video, I ran the commands:

```bash
$ bundle add devise
$ rails generate devise:install
$ bundle add activeadmin
$ rails generate active_admin:install --use_webpacker
```

This setup Devise, created an `AdminUser` model, created an `app/admin` folder & created the files required to use Webpacker for the ActiveAdmin assets.

## Resources, Filters & Scopes

ActiveAdmin comes with a few generators you can call via the terminal to help setup scaffolding. In the video I ran:

```bash
$ rails generate active_admin:resource Author
$ rails generate active_admin:resource Post
$ rails generate active_admin:resource Category
```

This generated some simple scaffold for the Author, Post & Category models in our admin panel.

I then went onto customising the `app/admin/posts.rb` file, allowing us more fine grain control over how our users would access & modify the Posts in the app.

```ruby
# app/admin/posts.rb
ActiveAdmin.register Post do
  filter :title
  filter :author_name, as: :string
  filter :created_at
  filter :categories

  scope :published

  index do
    selectable_column
    column :id
    column :title
    column :published?
    column :author
    column :created_at
    actions
  end

  permit_params :title, :body, :author_id, category_ids: []

  form do |f|
    f.inputs :title, :body, :author
    f.inputs "Categories" do
      f.input :categories, as: :check_boxes
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :body
      row :author
      row :created_at
      row :updated_at
      row :published_at
      row :categories
    end
    active_admin_comments
  end
end
```

## Custom Actions & Decorators

In the final video, I ran through how to setup a custom action within an ActiveAdmin resource & how to use [Draper](https://github.com/drapergem/draper) to decorate our models.

```ruby
# app/admin/posts.rb
ActiveAdmin.register Post do
  includes :author
  decorate_with PostDecorator

  # [snip]

  member_action :publish, method: :put do
    resource.publish!
    redirect_to resource_path, notice: "Published!"
  end

  action_item :publish, only: :show, if: proc { !resource.published? } do
    link_to 'Publish', [:publish, :admin, resource], method: :put
  end

  # [snip]
end
```

I'm a big fan of using Decorators (Sometimes called presenters), they offer a tidy way to say "In my views, I want the data from this model to always be formatted like this".

So for example, if I'm always going to want to output a Posts body with a dash of formatting, I'd use a decorator to decide how I want to format that field in a single location.

```ruby
# app/decorators/post_decorator.rb
class PostDecorator < ApplicationDecorator
  delegate_all

  def body
    helpers.simple_format(object.body)
  end
end
```
