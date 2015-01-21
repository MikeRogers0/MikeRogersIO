## MikeRogers.io ##

My personal website which shows off bits of my portfolio and ramblings from my blog.


# How to turn on

   bundle exec jekyll server -w -H 0.0.0.0

# How to deploy

   bundle exec jekyll build
   s3_website cfg apply
   s3_website push
