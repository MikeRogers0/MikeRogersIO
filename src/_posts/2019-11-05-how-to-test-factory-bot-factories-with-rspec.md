---
layout: post
title: How to Lint FactoryBot Factories with RSpec
description: Invalid factories are the worst. Here is a script I normally drop into my rails projects to help spot them.
---


I'm a big fan of using [FactoryBot](https://github.com/thoughtbot/factory_bot) when testing my Rails Apps with RSpec. The DSL is super easy to work with, so adding variations of a model for my tests is a breeze.

One drawback when working with factories (and fixtures!) is when a models validation or schema change, causing your factory to no longer be valid. It can sometimes be a little unobvious on exactly where the issue is.

A technique I use to help stop this, is to test the validity of the factories along with their traits at the start of my test suite.

To do this in RSpec, I setup a file in `spec/factories_spec.rb` with the following contents:

```ruby
# spec/factories_spec.rb
require 'rails_helper'

RSpec.describe FactoryBot do
  it { FactoryBot.lint traits: true }
end
```

Now whenever I get tripped up by an weird failing test, I can verify the factories I'm using in my tests are in the DB & working as intended.

*Update:* I updated my sample to use [FactoryBot.lint](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#linting-factories) - It's a way better approach to doing this.
