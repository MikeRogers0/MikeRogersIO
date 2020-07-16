---
layout: post
title: Storing a String in ActiveStorage
categories:
 – blog
published: true
meta:
  description: Rails ActiveStorage is a great way of saving files, but you can also store blobs of text.
  index: true
---

Recently, I came across a useful way to use ActiveStorage. I had a text field on my model, that stored about 200 kB of data that was only being read a handful of times. A quick estimate suggested this single column contained about 90% of the databases content.

The solution was to offload this columns data to S3 via Rails ActiveStorage, and only load it into memory as we required it.

## The Code

I used the [`StringIO`](https://ruby-doc.org/stdlib-2.6.4/libdoc/stringio/rdoc/StringIO.html) class to convert my string to a blob, then just attached that to my model. When I wanted to read it, I just downloaded the file from S3 and assigned the contents to an instance variable.

```ruby
class Report < ApplicationRecord
  has_one_attached :raw_data

  validates :raw_data, presence: true

  def data=(value)
    @data = value
    raw_data.attach(
      io: StringIO.new(value),
      filename: 'raw_data.txt',
      content_type: 'text/plain'
    )
  end

  def data
    @data ||= raw_data.blob.download
  end
end
```
