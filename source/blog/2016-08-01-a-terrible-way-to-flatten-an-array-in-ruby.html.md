---
layout: post
title: Flattening an array with Regex in Ruby (Interview Question)
categories:
 – blog
published: true
meta:
  description: I was asked to flatten an array in Ruby, without using the flatten method. Here is the terrible answer I came up with.
  index: true
---

I was recently shown how to solve [Fizz Buzz in Tensorflow](http://joelgrus.com/2016/05/23/fizz-buzz-in-tensorflow/) ( thanks [Sandy](https://twitter.com/partysandy_) btw! ) which was pretty neat, segwaying from that, this one time during an interview I used regex to flatten an array in Ruby. 

## The Question

Here is the question the interviewer asked me:

> Write some code that'll flatten an array of arbitrarily nested arrays of integers into a flat array of integers. e.g. [[1,2,[3]],4] -> [1,2,3,4] without using ruby's built in `.flatten` method.

A quick search [suggests it's a pretty common question](https://www.google.co.uk/search?q=Flatten+a+Ruby+Array+without+using+built-in+%27flatten%27+method) to be asked, and typically you'll solve it with recursion. However I wanted to be a unique snowfake.

## The Solution

Here is how I solved it with regex:

    # flatten_regex.rb
    # Example Usage:
    # [[1,2,[3]],4].flatten_with_regex

    class Array
      def flatten_with_regex
        self
          .to_s # This turns the array into: "[[1,2,[3]],4]"
          .gsub(/[\[|\]]/ism, "") # Remove those brackets, so it's now: "1,2,3,4"
          .split(", ") # Now rejoin into a single array: ["1","2","3","4"]
          .map(&:to_i) # Convert all items in array back to integers: [1,2,3,4]
      end
    end

Of course, for extra points I also wrote some tests for it:

    # flatten_regex_test.rb

    require "minitest/autorun"
    require "flatten_regex"

    class TestFlattenWithRegex < Minitest::Test

      def test_flattens_an_array_of_arbitrarily_nested_arrays_of_integers_into_a_flat_array_of_integers
        flattened_array = [[1,2,[3]],4].flatten_with_regex
        assert_equal [1,2,3,4], flattened_array
      end

      def test_flattens_an_empty_array
        flattened_array = [].flatten_with_regex
        assert_equal [], flattened_array
      end

      def test_can_flatten_a_very_nested_array
        silly_array = [3]
        8192.times do 
          silly_array = [silly_array]
        end

        flattened_array = silly_array.flatten_with_regex
        assert_equal 3, flattened_array
      end

    end
