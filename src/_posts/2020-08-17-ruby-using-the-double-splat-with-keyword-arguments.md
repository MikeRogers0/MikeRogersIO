---
layout: post
title: "Ruby: Using the Double Splat (**) with Keyword Arguments"
description: The double splat operator (**) in Ruby is really powerful, here's some examples of how to use it with Keyword Arguments.
---

The double splat in Ruby is a super powerful feature which in Ruby 2.7 allows a hash to be passed as arguments to a method.

It's very handy for when you'd like to transform some data, but want to have required arguments along with default values for other arguments.

## Using a hash for the arguments

To pass a hash as arguments in Ruby, you only need to add `**` before your hash. E.g:

```ruby
def method_name(name: nil, colour: 'Red')
  [name, colour]
end

hash = { name: 'Mike', colour: 'Blue' }
method_name(**hash)
# Returns: ["Mike", "Blue"]
```

## Setting default values

The nice thing about keyword arguments is you can set default values, so if you use a hash missing a few arguments, that'll be fine, e.g:

```ruby
def method_name(name: 'Gary', colour: 'Red')
  [name, colour]
end

hash = {}
method_name(**hash)
# Returns: ["Gary", "Red"]
```

## Requiring arguments to be present

In the event you want to be certain a value is passed, you can omit setting a default value in your keyword arguments & it'll throw an exception when an argument is missing. E.g:

```ruby
def method_name(name:, colour: 'Blue')
  [name, colour]
end

hash = { colour: 'Blue' }
method_name(**hash)
# Raises: ArgumentError (missing keyword: :name)
```

## Ignoring unwanted arguments

The double splat can also be used in your method definition for when you have arguments you don't necessarily care about, but don't want it to throw an error. E.g:

```ruby
def method_name(name:, **kwargs)
  puts kwargs.inspect
  puts [name].inspect
end

hash = { name: 'Mike', colour: 'Blue' }
method_name(**hash)
# Outputs:
# {:colour=>"Blue"}
# ["Mike"]
```

## Practical use-case

As you can see, using the double splat is pretty nifty. But when will you actually use it? Recently I used it to take a big hash of data from an API and pull out just the bits I needed. This meant I could have a fairly simple ruby class, which as long as it has the data it needed it would be able to run. Here is roughly what my code looked like:

```ruby
class Action::AnalyseDiff
  def initialize(before: nil, after:, repository:, **kwargs)
    @before = before
    @after = after
    @repository = repository
  end

  def call
    # Do some analysis with the git_diff
  end

  private

  def git_diff
    @git_diff ||= if single_commit?
      # Get the single commit
    else
      # Get the commits between the before & after
    end
  end

  def single_commit?
    @before.present?
  end
end

event_1 = {
  action: 'push',
  after: 'a-sha-of-a-git-commit',
  repository: 'MikeRogers0/SampleRepo',
  # ..
}

event_2 = {
  action: 'pull_request',
  before: 'a-sha-of-a-git-commit',
  after: 'a-sha-of-a-git-commit',
  repository: 'MikeRogers0/SampleRepo',
  # ..
}

Action::AnalyseDiff.new(**event_1.to_h).call
Action::AnalyseDiff.new(**event_2.to_h).call
```
