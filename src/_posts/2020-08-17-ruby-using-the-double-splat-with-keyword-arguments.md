---
layout: post
title: "Ruby: Using the Double Splat (**) with Keywords Arguments"
description: The double splat operator (**) in Ruby is really powerful, here's some examples of how to use it with Keywords Arguments.
---


## Using a hash for the arguments

```ruby
def method_name(name: nil, colour: 'Red')
  [name, colour]
end

hash = { name: 'Mike', colour: 'Blue' }
method_name(**hash)
# Outputs: ["Mike", "Blue"]
```

## Default Values

```ruby
def method_name(name: 'Gary', colour: 'Red')
  [name, colour]
end

hash = { }
method_name(**hash)
# Outputs: ["Gary", "Red"]
```

## Requiring arguments be present

```ruby
def method_name(name:, colour: 'Blue')
  [name, colour]
end

hash = { colour: 'Blue' }
method_name(**hash)
# Outputs: ArgumentError (missing keyword: :name)
```

## 

hash2 = { name: 'Mike', colour: 'Blue', extra_key: 'Sample' }
hash3 = { name: 'Mike' }


method_name(**hash2)
# Outputs: ArgumentError (unknown keyword: :extra_key)


method_name(**hash3)
# Outputs ["Mike", nil]
```
