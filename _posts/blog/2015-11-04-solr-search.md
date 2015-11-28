---
layout: post
title: Searching with Solr in Rails
categories:
 – blog
published: true
meta:
  description: SOLR
  index: true
  image: TODO
---

Building a search for your web app can become complicated when you want to start ordering by the relevancy of a model. Solr reduces a lot of this complexity and is fairly quick, however with a handful of small tweaks you can make it a touch more realiable and a little quicker.

For this article, I'm assuming you've already setup [sunspot_rails](https://github.com/sunspot/sunspot) on your rails app & just want to see how I made it better for me.

## Reindex with a worker 

I like to use [WebSolr](https://websolr.com/) (It's an Heroku Addon), it's pretty awesome but from time to time it does 503 (especially when I've been hitting their service a little hard). To stop the end user seeing the 503 errors, setup the `solr_index` method to run asynchronously like so:

```
class Post < ActiveRecord::Base
  searchable do
    string :title
    text :body
    time :published_at 
  end

  handle_asynchronously :solr_index
end
```

This means, that if the solr service returns a 500 error it'll try again a few seconds later & the end user shouldn't notice the issue. 
Also I don't add in `:solr_index!`, when I've had both methods running asynchronously I noticed my memory usage growing very rapidly.

## Only reindex when a limited amount of attributes change

Odds are you'll only be searching against a few attributes within your model, to tell solr to only reindex when they change use the `only_reindex_attribute_changes_of` argument.

```
class Post < ActiveRecord::Base
  searchable only_reindex_attribute_changes_of: [:title, :body, :published_at] do
    string :title
    text :body
    time :published_at 
  end
end
```

## Only index what you need

Use the `if` argument with a proc to only index models that should be in your results.

```
class Post < ActiveRecord::Base
  searchable if: proc { |post| post.published?  } do
    string :title
    text :body
    time :published_at 
  end
end
```


## Improving indexing speed with includes

To make indexing a touch faster when calling relationship within your searchable block, use the `include` argument. It eager loads in the assoicated models.

```
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
```
