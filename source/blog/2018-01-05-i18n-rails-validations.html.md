---
layout: post
title: Using I18n in Rails Validations
categories:
 – blog
published: true
meta:
  description: Don't hard code strings into your models, put them in your locales!
  index: true
---

Rails model validations are one of the most expressive and powerful aspects which makes Rails one of my favourite frameworks.

One of the more lesser known aspects is that you can pass in a symbol, and Rails will lookup the appropriate message to return via I18n. You can even pass in interpolations for when you'd like to pass in something specific to your model.

Here is an example:

    class User < ApplicationRecord
      # When using the `validates` method, only the translated model name,
      # translated attribute name and the value available for interpolation.
      # en.activerecord.errors.models.user.attributes.avatar.error_key:
      # "You've forgot the %{attribute} in %{model}"
      validates :avatar, presence: { message: :error_key }

      validate :validate_will_always_fail
      validate :validate_will_always_fail_with_interpolations

      private
      def validate_will_always_fail
        # en.activerecord.errors.models.user.attributes.avatar.error_type:
        # "No interpolations here"
        errors.add(:avatar, :error_type)
      end

      def validate_will_always_fail_with_interpolations
        # When using errors.add, you can pass in custom interpolations
        # en.activerecord.errors.models.user.attributes.base.another_error_type:
        # "Another error type: %{value}"
        errors.add(:base, :another_error_type, { value: name })
      end
    end

    # So running:
    user = User.new(name: 'Gary')
    user.valid?
    puts user.errors.messages.inspect

    # Would output:
    # {
    #   avatar: ["No interpolations here", "You've forgot the Avatar in User"],
    #   base: ["Another error type Gary"]
    # }


## Keep things standard

Using custom keys to be specific about what type of error occurred is super handy, plus having a "This will be translated in the future" will save you a lot of technical debt going forward. But it's important to note Rails does [ship with a bunch of standard validation messages](https://github.com/rails/rails/blob/b2eb1d1c55a59fee1e6c4cba7030d8ceb524267c/activemodel/lib/active_model/locale/en.yml#L8), where possible you should consider the standard message keys.
