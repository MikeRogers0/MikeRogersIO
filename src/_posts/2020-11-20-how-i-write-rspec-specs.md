---
layout: post
title: How I write RSpec Specs
description: This is my approach
---

## Model Classes

```ruby
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:described_instance) { build(:user, name: 'MikeRogers0') }

  describe '::created_after_date' do
    subject { described_class.created_after_date(1.day.ago) }

    let!(:user_week_ago) { create(:user, created_at: 1.week.ago) }
    let!(:user_day_ago) { create(:user, created_at: 1.dat.ago) }
    let!(:user_hour_ago) { create(:user, created_at: 1.hour.ago) }

    it do
      is_expected.to_not include(user_week_ago)
      is_expected.to include(user_day_ago)
      is_expected.to include(user_hour_ago)
    end
  end

  describe '#to_s' do
    subject { described_instance.to_s }
    it { is_expected.to eq('MikeRogers0') }
  end

  describe '#enabled!' do
    subject { described_instance.enabled! }
    let(:described_instance) { create(:user) }

    it { expect { subject }.to change { described_instance.reload.enabled? }.from(nil).to(DateTime) }
  end
end
```

## Stubbing API calls
