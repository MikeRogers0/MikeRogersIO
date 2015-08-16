---
layout: post
title: 6 Nifty Rails hacks you should be using
categories:
 – blog
published: true
meta:
  description: Six fairly generic Rails tips that are pretty obvious, but will improve performance and help keep your codebase tidier. Number 3 won't shock you.
  index: true
---

I've been working on a medium sized Ruby on Rails application for the last few months, here are some nifty (Heroku suitable) hacks I been using that have helped keep performance reasonable, while still keeping the apps codebase manageable.

## Serve your assets via a CDN

Serving stylesheets, images and other front end what-nots is not really what your workers should be concerning themselves with. Instead if you [serve assets via CDN](https://devcenter.heroku.com/articles/using-amazon-cloudfront-cdn#adding-cloudfront-to-rails) (like CloudFront or [Fastly](https://www.fastly.com/)) your application only has to serve the asset to your CDN when they've changed. This frees up your workers to focus performing the business actions (like updating values in the database) & can save the amount of dynos you need to run your app.

Additionally you'll receive a small performance boost as the browser is [downloading the assets in parallel](http://csswizardry.com/2013/01/front-end-performance-for-web-designers-and-front-end-developers/#section:maximising-parallelisation) as they'll be served on from a different domain. Awesome!

## Views should be logic-free

{% img /uploads/2015/08/16/logic-in-views2.jpg 597x402 "If you put logic in your views, you're going to have a bad time - South Park Ski Instructor" %}

I stumbled across [mustache](https://github.com/mustache/mustache) just over a year ago, at the time I felt the concept of logic-free views was an unnecessary limitation (If I remember correctly I thought the idea was batshit crazy). However in the last year I've really warmed to the idea as it makes managing views much more simpler, as forces you to move logic to either a helper, or the model (Which is easier to test).

While I've not fully converted to mustache, I aim to follow the concept of views having little to no business logic as possible.

## Cache some of the things!

I was taught when I started programming that "Premature optimization is the root of all evil", this always made me weary of adding caching layers in to my application. However the [Caching in Rails 4](http://guides.rubyonrails.org/v4.2.0/caching_with_rails.html#basic-caching) is pretty simple to work with, and doesn't add a big layer of complexity to the code base.

As a rule of thumb, I've been trying to add a caching layer around database queries that are performed often (Based on the analytics), but will not have their results change very often. Then where possible just wrapping the output HTML/JSON in a caching block. 

## CarrierWave for image uploads

In the past I've used [Paperclip](https://github.com/thoughtbot/paperclip), but it felt like whenever I ran into trouble with it I'd end up reading a solution from the pre Rails 3.2 era. While this is mostly an issue with search results (There is up to date advice out there), it is frustrating to have to hunt for good code samples.

A better alternative I found was [CarrierWave](https://github.com/carrierwaveuploader/carrierwave), which from a my point of view feels much more suited towards the type of projects I'm working on, especially when you have multiple images per a model that may be updated in a single request. Also the way of defining image sizes (Grouped in their own `uploaders` file) helps keep my models much more tidier.

That said using CarrierWave on it's own is a bit like eating an entire block of cheese (Much easier with wine and friends). One of the additional required gems is [carrierwave_backgrounder](https://github.com/lardawge/carrierwave_backgrounder), which allows not only for images to be processed in the background (Which if you're not doing, start doing now) but also lets you save images from a URL in the background. This moves a bunch of the processing from a web worker to a background worker, which provides a much snappier experience for your users.

## Have users upload directly to your file storage

Having users upload large files to your server, then having a worker save them to somewhere can be unreliable & super time consuming. A better approach is to use [s3_direct_upload](https://github.com/waynehoover/s3_direct_upload) and to have your users upload their files to S3, then send you the URL to the file. 

The advantage of this is all your worker needs to do is save the URL to the database and queue it up to be processed. This frees up the worker to handle another users request.

## Be selective over the gems you use

Every gem you use comes with a memory footprint and adds an additional cog that needs to be kept up to date. 

Using gems such as [simple_form](https://github.com/plataformatec/simple_form) and [shareable](https://github.com/hermango/shareable) may seem like a fantastic way to save a few minutes here and there, but unless you are using them to their full extent you may want to ditch them.

