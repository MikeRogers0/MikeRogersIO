---
layout: post
title: Stop resizing images with Ruby
categories:
 – blog
published: true
meta:
  description: Ruby shouldn't be used to resize images, but there is a better way.
  index: true
---

Back in the day, I used [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) and [MiniMagick](https://github.com/minimagick/minimagick) to handle my image upload and resizing needs, and for the most part it done a swell job. I even had a pretty decent setup where the users would upload their image to S3, then a Heroku Worker Dyno would do the handle the actual image manipulation, all cached by CloudFront.

However, every once in a while I'd get a weird memory usage spike. Normally caused by a user uploading a remarkably large image and my worker trying to resize the various versions (Some of which, probably wouldn't even be seen) as quickly as possible.

The memory spikes were easily fixed by better sidekiq configuration, but it really ate away at me that I was creating images that were seldom used.

## To the Cloud of resizing

There are a few SaaS providers who handle just this use case, the two main ones I liked were [Cloudinary](https://cloudinary.com/) and [Fastly](https://docs.fastly.com/api/imageopto/). I'm a big fan of Cloudinary as it has a really nice [Ruby Gem with a CarrierWave integration](https://github.com/cloudinary/cloudinary_gem), but I'd encourage you to explore both options.

I've setup a [fresh Rails 5.1 project](https://github.com/MikeRogers0/CloudinaryHerokuDemo), which shows an example integration which can deployed to Heroku. It also auto tags your images depending on who uploaded them, and their corresponding model.

It's pretty easy to setup to! Just mount your uploader as normalL

    # app/models/user.rb
    class User < ApplicationRecord
      # Mount your uploads as usual.
      mount_uploader :avatar, User::AvatarUploader
    end

Then setup your uploader with your versions:

    # app/uploaders/user/avatar_uploader.rb
    class User::AvatarUploader < ApplicationUploader
      # http://res.cloudinary.com/demo/image/upload/w_300,h_150,c_fit/sample.jpg
      version :default do    
        eager
        #process resize_to_limit: [150, 150]
        process resize_to_fill: [180, 180]
        cloudinary_transformation quality: 'auto', fetch_format: 'auto'
      end

      # http://res.cloudinary.com/demo/image/upload/w_300,h_150,c_fit/sample.jpg
      version :favicon do    
        process convert: 'ico'
        process resize_to_fill: [48, 48]
        cloudinary_transformation radius: 'max'
      end

      # http://res.cloudinary.com/demo/image/upload/w_300,h_150,c_fit/sample.jpg
      version :apple_touch do    
        process convert: 'png'
        process resize_to_fill: [114, 114]
      end
    end

Then use the `cl_image_upload` method to skip uploading images directly to your server.

    <!-- app/views/users/_form.html.erb -->
    <%= form.cl_image_upload(:avatar, tags: form.object.avatar.direct_uploading_tags, allowed_formats: ['jpg'], html: { id: 'user_avatar' }) %>

Easy as pie right?!

## Future options

Cloudinary, like most SaaS can begin to feel a [little bit expensive](https://cloudinary.com/pricing) if you're using 11GB/51GB of storage. 
