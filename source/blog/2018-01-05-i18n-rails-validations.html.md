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

Rails model validations are one of the most expressive and powerful aspects which makes development a breeze.

One of the more lesser known aspects is that you can pass in a symbol, and rails will lookup the appropriate message to return via I18n.

Here is an example:

    class User
      # 
      validates :field, presence: { message: :error_key }
      validate :validate_will_always_fail

      private
      def validate_will_always_fail
        errors.add(:field, :error_type)
      end
    end

This will lookup the error message via the locale path ‘en.activerecord:..’ pretty handy!
    en.errors.models.user.attributes.field.error_key
    en.errors.models.user.attributes.field.over_active_client_limit


Rails has a bunch of default in keys you can pass ( from https://github.com/svenfuchs/rails-i18n/blob/e489753e293e77a6c7bee25a5a7e4c36a22d897b/rails/locale/en.yml#L111 ):

[table]
