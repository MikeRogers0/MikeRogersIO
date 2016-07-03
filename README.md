## MikeRogers.io ##

My personal website which shows off bits of my portfolio and ramblings from my blog.


# How to turn on

    foreman start

or

    bundle exec jekyll server -w -H 127.0.0.1

# How to deploy

    bundle exec jekyll build
    s3_website cfg apply
    s3_website push
