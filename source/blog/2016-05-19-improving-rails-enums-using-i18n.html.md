---
layout: post
title: Improving Rails Enums using i18n
categories:
 – blog
published: true
meta:
  description: A helper method I wrote to make Enum in Rails more user presentable using i18n.
  index: true
---

As of Rails 4.1, you can use [Enums](http://api.rubyonrails.org/v4.1/classes/ActiveRecord/Enum.html) to sensibly store a set of fixed constants against a field. These are handy as upon declaring your enum attributes, Rails will define a bunch of methods and scopes that follow Ruby's naming conventions.

One of the areas I felt they didn't totally satisfy my needs, was when it came to displaying the enum fields value to the end user in a view. 

## Enum I18n Helper

The solution I decided was most "the rails way" was to store a translated version of the enum key in the locale YAML file, then use a helper to retrieve the translated value. Below is the helper.

```ruby
# app/helpers/enum_i18n_helper.rb
module EnumI18nHelper

  # Returns an array of the possible key/i18n values for the enum
  # Example usage:
  # enum_options_for_select(User, :approval_state)
  def enum_options_for_select(class_name, enum)
    class_name.send(enum.to_s.pluralize).map do |key, _|
      [enum_i18n(class_name, enum, key), key]
    end
  end

  # Returns the i18n version the models current enum key
  # Example usage:
  # enum_l(user, :approval_state)
  def enum_l(model, enum)
    enum_i18n(model.class, enum, model.send(enum))
  end
  
  # Returns the i18n string for the enum key
  # Example usage:
  # enum_i18n(User, :approval_state, :unprocessed)
  def enum_i18n(class_name, enum, key)
    I18n.t("activerecord.enums.#{class_name.model_name.i18n_key}.#{enum.to_s.pluralize}.#{key}")
  end
end
```

## Usage

For this example, I'm going to create the enum `approval_state` in my User model, like so:

```ruby
# app/model/user.rb
class User < ActiveRecord::Base
  enum approval_state: { unprocessed: 0, approved: 1, declined: 2 }
end
```

The YAML file should then contain a list of the translated keys under the pluralised version of the enum attribute:

```yml
# config/locales/activerecord.en.yml
en:
  activerecord:
    enums:
      user:
        approval_states:
          unprocessed: "Unprocessed"
          approved: "Approved"
          declined: "Declined"
```

You can then output a users current `approval_state` by doing the following:

```erb
<%= enum_l(user, :approval_state) %>
```

You can also have a list of all the available options for that enum in a select box, like so:

```erb
 <div class="form-group">
   <%= f.label :approval_state %>
   <%= f.select :approval_state, enum_options_for_select(User, :approval_state) %>
 </div>
 ```

## Update 2019: I found a better solution

After writing this, I found this [StackOverflow post with a better solution](https://stackoverflow.com/questions/22827270/how-to-use-i18n-with-rails-4-enums/36335591#36335591). I think it's a much better compared to the one posted above.

