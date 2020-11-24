---
layout: post
title: How I write RSpec Specs
description: This is my approach
---

I love writing my tests with RSpec, I find it super expressive. Recently I've been taking a dive into the best way to format my tests.

The main sources I've used so far are:

- [Better Specs](https://www.betterspecs.org/)
- [rspec-style-guide](https://github.com/rubocop-hq/rspec-style-guide)

They're both worth reading, but here is my current approach.

## Naming tests

Naming tests is hard. I normally aim to write just enough information so the failure output helps me locate the issue, but not so much that updating a test requires me to rewrite lots of information.

I've fallen into the pattern of adding something to the `describe` block, but not adding something to the `it` block. It seems to work for me for now.

## Class methods

When testing class methods, I start the describe block with `::` then output the method name, then add any hints about the argument types. I've stuck with `::` because it's closer to what I see when I inspect an class.

I then use the `described_class` helper to let me use the class I defined in `RSpec.describe`. If I need any data setup before hand, I'd I use `let!` as then I can reference the setup data more cleanly.

```ruby
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '::created_after(DateTime)' do
    subject { described_class.created_after(1.day.ago) }

    # I prefer let! over before
    let!(:user_week_ago) { create(:user, created_at: 1.week.ago) }
    let!(:user_day_ago) { create(:user, created_at: 1.day.ago) }
    let!(:user_hour_ago) { create(:user, created_at: 1.hour.ago) }

    # No description as it should be super 
    it do
      is_expected.to_not include(user_week_ago)
      is_expected.to include(user_day_ago)
      is_expected.to include(user_hour_ago)
    end
  end
end
```

## Instance methods

Like BetterSpecs I use the describe the method by starting with a `#`, then the method name.

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

### Toggles



```ruby
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:described_instance) { build(:user, name: 'MikeRogers0') }

  describe '#enabled!' do
    subject { described_instance.enabled! }
    let(:described_instance) { create(:user) }

    it { expect { subject }.to change { described_instance.reload.enabled? }.from(nil).to(DateTime) }
  end
end
```

## Stubbing API calls

I use WebMock over VCR.

```ruby
describe MeetingPlace::Events do
  let(:described_instance) { described_class.new }
  let(:api_response_body) { File.read('spec/fixtures/files/meetingplace.io/api/v1/group/virtual-coffee/events.json') }
  let!(:api_endpoint) do
    stub_request(:get, 'https://meetingplace.io/api/v1/group/virtual-coffee/events.json')
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
