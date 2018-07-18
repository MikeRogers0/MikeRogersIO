---
layout: post
title: Combining timecop and VCR during testing
categories:
 – blog
published: true
meta:
  description: Speed up your tests and make them more re-playable.
  index: true
---

On almost every ruby project I work on, I always include the following two gems to make writing tests a dash easier:

1. [timecop](https://github.com/travisjeffery/timecop) - A really simple interface for travelling between times, and freezing at a particular time in your tests.
2. [vcr](https://github.com/vcr/vcr) - Record and replay HTTP requests to the outside world. Perfect to speed up a test suite and allows me to work offline.

Combined, these allow me to capture a bunch of HTTP requests and replay them without having to worry about any time based conditions.

## Example Usage

Setting up new customer on Stripe then confirming only 1 customer was created is a good use case for this: 


    # spec/acceptance/sign_up_spec.rb
    require 'acceptance/acceptance_helper'
    
    # Passing the `vcr: true` argument, tells vcr we'd like to record http requests in this feature.
    feature 'Sign up', acceptance: true, vcr: true do
      # Use a `let` to store the time the test started
      let(:start_time){ VCR.current_cassette&.originally_recorded_at || Time.current }

      before do
        # Travel to when we first ran this test
        Timecop.travel( start_time )
        # [..] Any setup in the external API
      end

      after do
        # [..] Any cleanup in the external APIs
      end

      scenario 'With valid details, just one Stripe Customer is created' do
        expect(User.count).to eq(0)

        visit new_user_registration_path
        # [..] User completes a signup form
      
        expect(User.count).to eq(1)

        # Make sure just the one customer has been created since this test started
        expect(Stripe::Customer.all(created: { gte: start_time.to_i } ).count).to eq(1)
        
      end
    end

It's important to confirm an external API has worked as you expect, but constantly hitting an external API in your test suite is kind of unnecessary. Ideally, you should periodically delete the `spec/vcr_cassettes` folder to confirm your external API requests are still valid. But how often you do that is totally up to you :)
