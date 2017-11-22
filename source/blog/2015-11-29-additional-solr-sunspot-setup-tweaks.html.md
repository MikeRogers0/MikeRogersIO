---
layout: post
title: Additional Ruby Solr Sunspot setup tweaks
categories:
 – blog
published: true
meta:
  description: A few tweaks I made to my searchable blocks to make Solr Sunspot better.
  index: true
---

Building a search for your rails app can become a touch complicated when you need to order by relevancy. 
Solr reduces this complexity by moving the heavy lifting off to it's own service. It's fairly quick & the rails wrapper has keeps things very tidy, however with a handful of small tweaks you can make it a touch more reliable and a little quicker.

For this article, I'm assuming you've already setup [sunspot_rails](https://github.com/sunspot/sunspot) on your rails app and you just want to know a few tweaks I found worthwhile in my Heroku enviroment. 

## Reindex with a worker 

I like to use [WebSolr](https://websolr.com/) (It's an Heroku Addon), it's pretty awesome but from time to time it does throw 50x errors (especially when I've been hitting their service a little hard). To stop the end user seeing the 503 errors, setup the `solr_index` method to run asynchronously like so:

    class Post < ActiveRecord::Base
      searchable do
        string :title
        text :body
        time :published_at 
      end

      handle_asynchronously :solr_index
    end

This means, that if the solr service returns a 50x error it'll try again a few seconds later & the end user shouldn't notice the issue. 
Also I don't add in `:solr_index!`, as when I've had both methods running asynchronously I noticed my memory usage growing very rapidly.

## Only reindex when a limited amount of attributes change

Odds are you'll only be searching against a few attributes within your model, to tell solr to only reindex when it sees these attributes have changed, use the `only_reindex_attribute_changes_of` argument with an array of symbols.

    class Post < ActiveRecord::Base
      searchable only_reindex_attribute_changes_of: [:title, :body, :published_at] do
        string :title
        text :body
        time :published_at 
      end
    end

## Only index what you need

Use the `if` argument with a proc to only index models that should be in your results.

    class Post < ActiveRecord::Base
      searchable if: proc { |post| post.published?  } do
        string :title
        text :body
        time :published_at 
      end
    end

In this case, if the post isn't published it will be omitted from the search index completly.


## Improving indexing speed with includes

If you're calling a relationship within your searchable block, use the `include` argument. It eager loads in the associated models

    class Post < ActiveRecord::Base
      searchable include: [:categories, :author] do
        string :title
        string :author_name do 
          author.name
        end
        string :categories_list do 
          categories.map(&:name).join(", ")
        end
        text :body
        time :published_at 
      end
    end
