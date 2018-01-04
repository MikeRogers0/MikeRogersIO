---
layout: post
title: Stop resizing images with Ruby
categories:
 – blog
published: true
meta:
  description: Ruby shouldn't be used to resize images, instead do it in the cloud.
  index: true
---

Back in the day, I used [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) and [MiniMagick](https://github.com/minimagick/minimagick) to handle my image upload and resizing needs, and for the most part it did a swell job. I even had a pretty decent setup where the users would upload their images directly to S3, then a Heroku Worker Dyno would do the handle the actual image manipulation, all cached by CloudFront.

However, every once in a while I'd get a weird memory usage spike. Normally caused by a user uploading a remarkably large image and my worker trying to resize the various versions (Some of which, probably wouldn't even be seen) as quickly as possible.

The memory spikes were easily fixed by better sidekiq configuration, but it really ate away at me that I was creating images that were seldom used.

## Resizing on the fly in the cloud

There are a few SaaS providers who handle just this use case, the two main ones I liked were [Cloudinary](https://cloudinary.com/) and [Fastly](https://docs.fastly.com/api/imageopto/). I'm a big fan of Cloudinary as it has a really nice [Ruby Gem with a CarrierWave integration](https://github.com/cloudinary/cloudinary_gem), but I'd encourage you to explore both options.

It's pretty easy to setup to! Just mount your uploader as normal:

    # app/models/user.rb
    class User < ApplicationRecord
      # Mount your uploads as usual.
      mount_uploader :avatar, User::AvatarUploader
    end

Then setup your uploader with your versions:

    # app/uploaders/user/avatar_uploader.rb
    class User::AvatarUploader < ApplicationUploader
      # http://res.cloudinary.com/demo/image/upload/c_fill,f_auto,h_180,q_auto,w_180/sample.png
      version :default do    
        eager
        #process resize_to_limit: [150, 150]
        process resize_to_fill: [180, 180]
        cloudinary_transformation quality: 'auto', fetch_format: 'auto'
      end

      # http://res.cloudinary.com/demo/image/upload/c_fill,h_48,r_max,w_48/sample.ico
      version :favicon do    
        process convert: 'ico'
        process resize_to_fill: [48, 48]
        cloudinary_transformation radius: 'max'
      end

      # http://res.cloudinary.com/demo/image/upload/c_fill,h_114,w_114/sample.png
      version :apple_touch do    
        process convert: 'png'
        process resize_to_fill: [114, 114]
      end
    end

You can link to the image version by passing the version type in the `url` method. You can also use the `cl_image_upload` method to upload directly to Cloudinary servers, skipping having the data stop at your server on the way to Cloudinary.

    <!-- app/views/users/_form.html.erb -->
    <%= image_tag form.object.avatar.url(:default) if form.object.avatar.present? %>
    <%= form.cl_image_upload(:avatar, allowed_formats: %w(jpg jpeg gif png)) %>

Easy as pie right?! I've setup a [fresh Rails 5.1 project](https://github.com/MikeRogers0/CloudinaryHerokuDemo), which shows an example integration which can be deployed to Heroku.

## Future options

Cloudinary, like most SaaS can begin to feel a [little bit expensive](https://cloudinary.com/pricing) if you're not utilizing a large percentage of your plan. However as mentioned above Fastly is a reasonable alternative. If you're really scaling up, it's also possible to [resize images via AWS Lambda](https://github.com/ysugimoto/aws-lambda-image).
