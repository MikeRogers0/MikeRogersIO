---
layout: video
title: Fixing "Detected sqlite3 gem which is not supported on Heroku" when deploying
  Rails to Heroku
youtube_id: AA6GZBPeveU
published_at: '2021-01-31T14:54:02Z'
---
When I first deployed Rails to Heroku I was greeted with the error:

    Failed to install gems via Bundler
    Detected sqlite3 gem which is not supported on Heroku:
    https://devcenter.heroku.com/articles/sqlite3

The solution is to use postgres instead of sqlite3, which you can do by running:

    bundle exec rails db:system:change --to=postgresql

I hope this helps anyone who runs into this error :)

# Chapters

0:00 - The error
0:38 - How to fix it
2:27 - Thank you

# Follow Me Online

➡ Blog: https://mikerogers.io/
➡ Twitter: https://twitter.com/MikeRogers0
➡ GitHub: https://github.com/mikerogers0
➡ YouTube: https://www.youtube.com/c/MikeRogers0
➡ BuyMeACoffee: https://www.buymeacoffee.com/MikeRogers0
➡ Dev.to: https://dev.to/mikerogers0

#RubyOnRails #Heroku