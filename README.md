# MikeRogers.io ##

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/df7d23ccf98c47179b1eec1d72568785)](https://app.codacy.com/app/MikeRogers0/MikeRogersIO?utm_source=github.com&utm_medium=referral&utm_content=MikeRogers0/MikeRogersIO&utm_campaign=Badge_Grade_Dashboard)

My personal website which shows off bits of my portfolio and ramblings from my blog.

## Deploying

    cap production deploy

### Setup

    cap production puma:config
    cap production puma:nginx_config

## TODO

### Posts

 - Do you need a complex site? 

### Moves gists into posts

I need to replace all the `{ gist }` type tags with their actual code blocks

### Remove rubbish posts

Some of the information is fairly dated and simply not helpful. I should remove the posts which are not decent any more.

### Swap out Font-Awesome with SVGs

I think it would be more performant to create a layered SVG from the icons I'm using ( https://github.com/encharm/Font-Awesome-SVG-PNG/blob/master/black/svg/instagram.svg ) then use that instead of importing all the font-awesome stuff.

### Portfolios

I need a portfolio of my work, maybe make it look like https://foundation.zurb.com/templates-previews-sites-f6/product-page.html
