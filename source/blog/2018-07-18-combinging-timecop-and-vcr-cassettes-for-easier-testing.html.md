---
layout: post
title: Combining timecop and VCR for easier testing
categories:
 – blog
published: true
meta:
  description: 
  index: true
---

On almost every ruby project I work on I always include the following two gems to aid testing:

1. [timecop](https://github.com/travisjeffery/timecop) - A really simple interface for travelling between times, and freezing on a particular time in your tests.
2. [vcr](https://github.com/vcr/vcr) - Record and replay HTTP requests to the outside world. Perfect to speeding up a test suite and allowing me to work offline.

Combined, these allow me to capture a bunch of HTTP requests and replay them without having to worry about any time based conditions.

## Example Usage

Setting up new customer on Stripe then confirming only 1 customer was created is a good use case for this. It's important to confirm an external API has worked a you expect, but constantly hitting an external API in your test suite is kind of unnecessary.


require 'acceptance/acceptance_helper'

feature 'Sign up', acceptance: true, vcr: true do
  let(:start_time){ VCR.current_cassette&.originally_recorded_at || Time.current }

  before do
    Timecop.travel( start_time )
  end

  scenario 'with valid details a Stripe Customer is created' do
    expect(User.count).to eq(0)

    visit new_user_registration_path
    # [..] User completes a signup form
  
    expect(User.count).to eq(1)

    # Make sure just the one customer has been created
    expect(Stripe::Customer.all(created: { gte: start_time.to_i } ).count).to eq(1)
    
  end
end
