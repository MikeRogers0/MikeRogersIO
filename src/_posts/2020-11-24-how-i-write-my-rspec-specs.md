---
layout: post
title: How I write my RSpec Specs
description: I'm a big fan of TDD, this is my approach for keeping my RSpec specs super tidy.
---

I love writing my tests with RSpec, I find it really expressive compared to other testing approaches. Recently I've been taking a dive into the best way to format my tests.

The main sources I've used so far are:

- [Better Specs](https://www.betterspecs.org/)
- [rspec-style-guide](https://github.com/rubocop-hq/rspec-style-guide)

They're both worth reading, though here is a quick summary of my current approach.

## Naming tests

Naming tests is hard. I normally aim to write just enough information so the failure output helps me locate the issue, but not so much that if the logic changes I don't need to rewrite much. As a result I've fallen into the pattern of adding something to the `describe` block, but not adding much to the `it` block. It seems to work for me.

## Class methods

When testing class methods, I start the describe block with `::` then output the method name, then add any hints about the argument types. I've stuck with `::` because it's closer to what I see when I inspect a class in IRB.

I then use the `described_class` helper as much as I can, as it uses the class name defined via `RSpec.describe`. If I need any data setup before hand, I use `let!` as then I can reference the setup data more cleanly.

```ruby
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '::created_after(DateTime)' do
    subject { described_class.created_after(1.day.ago) }

    # I prefer let! over a before block
    let!(:user_week_ago) { create(:user, created_at: 1.week.ago) }
    let!(:user_day_ago) { create(:user, created_at: 1.day.ago) }
    let!(:user_hour_ago) { create(:user, created_at: 1.hour.ago) }

    # No description as the test code should be self explanatory.
    it do
      is_expected.to_not include(user_week_ago)
      is_expected.to include(user_day_ago)
      is_expected.to include(user_hour_ago)
    end
  end
end
```

## Instance methods

Like BetterSpecs I use the describe the method by starting with a `#`, then the method name. I'm a fan of using `is_expected` as it just calls `subject` under the hood, but reads a bit more nicely.

```ruby
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:described_instance) { build(:user, name: 'MikeRogers0') }

  describe '#to_s' do
    subject { described_instance.to_s }
    it { is_expected.to eq('MikeRogers0') }
  end
end
```

### Toggles

When I'm changing an object & want to confirm it changed, I normally fall back to the `change` method with a reload. I used to used `change(described_instance, :enabled_at)` but I preferred the explicit `reload`.

```ruby
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:described_instance) { build(:user, name: 'MikeRogers0') }

  describe '#enabled!' do
    subject { described_instance.enabled! }
    let(:described_instance) { create(:user) }

    it { expect { subject }.to change { described_instance.reload.enabled_at }.from(nil).to(DateTime) }
  end
end
```

## Stubbing API calls

I use [WebMock](https://github.com/tooky/webmock) over [VCR](https://github.com/vcr/vcr), I prefer the explicitness of mocking individual HTTP calls over the catch all VCR offers.

```ruby
describe MeetingPlace::Events do
  let(:described_instance) { described_class.new }
  let(:api_response_body) do
    File.read('spec/fixtures/files/meetingplace.io/api/v1/group/company-name/events.json')
  end
  let!(:api_endpoint) do
    stub_request(:get, 'https://meetingplace.io/api/v1/group/company-name/events.json')
      .and_return(status: 200, body: api_response_body)
  end

  describe '#call' do
    subject { described_instance.new.call }

    it do
      is_expected.to all(be_a(MeetingPlace::Event))
      expect(events_endpoint).to have_been_requested.times(1)
    end
  end
end
```
