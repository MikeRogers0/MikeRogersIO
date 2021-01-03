---
layout: post
title: How To Use API Keys for your SendGrid SMTP Integration
description: SendGrid emailed me saying I needed to use an API Key for their Heroku Add-on. Here is how I configured it for Ruby on Rails.
---

I use SendGrid to handle the sending of emails for within my Ruby on Rails apps. I am usually hosted on Heroku, so I'm a fan of using the [SendGrid add-on](https://elements.heroku.com/addons/sendgrid), which configures two ENV variables `SENDGRID_USERNAME` & `SENDGRID_PASSWORD` for my application to use.

I received an email from SendGrid with the subject line "Authenticate with API Keys", which stated they are [deprecating using the username & password](https://sendgrid.com/docs/for-developers/sending-email/upgrade-your-authentication-method-to-api-keys/#upgrade-to-api-keys-for-your-smtp-integration) for sending emails with SMTP. Instead they'd like me to generate an API key with just enough permissions to send an email.

Annoyingly their documentation didn't clearly state which permissions I needed to select that would give my API key the ability to send emails via SMTP. However, I figured it out & here are my notes :)

## Creating the API Key

Within my Heroku App, I logged into the SendGrid UI via my resources panel, and then navigated to [https://app.sendgrid.com/settings/api_keys](https://app.sendgrid.com/settings/api_keys).

On this page I clicked the "Create API Key" button, which opened the form to create an API Key and select the permissions I wanted to give that key access to.

### API Key Permissions

For the permissions, I selected **"Restricted Access"** & gave **full access** to just the **"Mail Send"** option. This meant the API key I was creating would only have the ability to send emails, anything else would return an error.

![Screenshot of the permission panel, with Mail Send selected](/2021/01/sendgrid-api-key-smtp-permission.png)

It then returned an API key, which I saved to my Heroku application as the ENV `SENDGRID_API_KEY`.

## Ruby on Rails Configuration for ActionMailer

I store my ActionMailer configuration within an initializer stored in `config/initializers/action_mailer.rb`, which only configures the SMTP settings if the SendGrid ENV is present.

The two changes I had to make to this file were:

1. Set the `user_name` to be `apikey`
2. Set `password` to be `ENV['SENDGRID_API_KEY']`

```ruby
# config/initializers/action_mailer.rb
Rails.application.configure do
  if ENV["SENDGRID_API_KEY"].present?
    config.action_mailer.smtp_settings = {
      address: "smtp.sendgrid.net",
      port: 587,
      authentication: :plain,
      user_name: "apikey",
      password: ENV["SENDGRID_API_KEY"],
      domain: "heroku.com",
      enable_starttls_auto: true
    }
  end
end
```

## Final Thoughts

I only use SendGrid for sending a few transactional emails a day from within my Ruby on Rails apps, so this extra setup on top of configuring my DNS is kind of a pain. Though, I do feel a bit more secure that my credentials for SendGrid are now more limited in their abilities.

It would be nice if out of the box, the Heroku add-on configured an API key for just SMTP.
