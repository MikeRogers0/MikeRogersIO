---
layout: post
title: Removing Active Storage Routes from Rails 5.2
categories:
 – blog
published: true
meta:
  description: Active Storage is pretty cool, but it added new routes to my old rails apps.
  index: true
---

Rails 5.2 has [landed](http://weblog.rubyonrails.org/2018/4/9/Rails-5-2-0-final/) and it brings some pretty cool new additions to the Rails stack.

However while upgrading one of my apps, I ran `rails routes` and noticed some new Active Storage routes had appeared:

           rails_service_blob GET  /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
    rails_blob_representation GET  /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
           rails_disk_service GET  /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
    update_rails_disk_service PUT  /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
         rails_direct_uploads POST /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

As I didn't intend to have any uploaded content in this app, I wanted to remove them. The [documentation](http://edgeguides.rubyonrails.org/active_storage_overview.html) unfortunately doesn't mention much about these new routes. So I got digging through the rails core code & found a solution.

## How to remove these routes

In your `config/application.rb` file, find the line:

    require 'rails/all'

And replace it with:

    require "rails"

    # Include each railties manually, excluding `active_storage/engine`
    %w(
      active_record/railtie
      action_controller/railtie
      action_view/railtie
      action_mailer/railtie
      active_job/railtie
      action_cable/engine
      rails/test_unit/railtie
      sprockets/railtie
    ).each do |railtie|
      begin
        require railtie
      rescue LoadError
      end
    end

What this will do is instead of requiring [rails/all](https://github.com/rails/rails/blob/master/railties/lib/rails/all.rb), it'll just require the railties we're planning to use.

By removing `active_storage/engine`, the Active Storage railties is no longer required and the routes it requires are no longer mounted. 👍
