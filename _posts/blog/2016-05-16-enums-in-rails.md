---
layout: post
title: Rails enums & i18n 
categories:
 – blog
published: true
meta:
  description: enums
  index: true
---

Ruby on Rails like most decent frameworks, has a lot of small functionality that when used correctly can save a lot of development time. Enums are a great example of this.


The stuff to add to your class
```
class User < ActiveRecord::Base

  enum approval_state: { unprocessed: nil, approved: 1, declined: 2 }

  def display_approval_state
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.approval_states.#{approval_state}")
  end

  def self.approval_states_attributes_for_select
    approval_states.map do |approval_state, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.approval_states.#{approval_state}"), approval_state]
    end
  end

end
```

I think the above could be better off in a helper prehaps?

The migration
```
add_column :users, :approval_state, :integer, default: nil, null: true
```

The YAML file
```
en:
  activerecord:
    attributes:
      user:
        approval_states:
          unprocessed: "Unprocessed"
          approved: "Approved"
          declined: "Declined"
```

Output in a form
```
<div class="form-group">
  <%= f.label :approval_state %>
  <%= f.select :approval_state, User.approval_state_attributes_for_select %>
</div>
```

## Footnotes / Gotchas

### This kind of functionlaity could be better off in a gem?
Probably, but screw making a gem & maintaing it for what is ~8 lines of code.

### Don't use 0 as the default value in the DB

I found using the default value of "0" in the DB returned nil. For  
