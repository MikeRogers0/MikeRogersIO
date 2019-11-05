---
layout: post
title: How to Test FactoryBot Factories with RSpec
categories:
 – blog
published: true
meta:
  description: Invalid factories are the worst. Here is a script I normally drop into my rails projects.
  index: true
---

I'm a big fan of using [FactoryBot](https://github.com/thoughtbot/factory_bot) when testing my Rails Apps with RSpec. The DSL is super easy to work with, so adding variations of a model for my tests is a breeze.

One drawback when working with factories (and fixtures!) is when a models validation or schema change, causing your factory to no longer be valid. It can sometimes be a little unobvious on exactly where the issue is.

A technique I use to help stop this, is to test the validity of the factories along with their traits at the start of my test suite. 

To do this in RSpec, I setup a file in `spec/factories_spec.rb` with the following contents:

```ruby
# spec/factories_spec.rb
require 'rails_helper'

# Loop through all the factories, check their valid & can save.
FactoryBot.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    it { expect(build(factory_name)).to be_valid }
    it { expect(create(factory_name).persisted?).to eq(true) }

    # Loop through this factories traits, check them also.
    FactoryBot.factories[factory_name].defined_traits.each do |trait|
      context "trait: #{trait}" do
        it { expect(build(factory_name, trait.name)).to be_valid }
        it { expect(create(factory_name, trait.name).persisted?).to eq(true) }
      end
    end
  end
end
```

Now whenever I get tripped up by an weird failing test, I can verify the factories I'm using in my tests are in the DB & working as intended.
