#!/bin/bash

echo "Running Release Tasks"
if [ "$AFTER_RELEASE_INVALIDATE_CDN" == "true" ]; then 
  echo "Invalidating CDN"
  bundle exec middleman cdn
fi

if [ "$AFTER_RELEASE_PING_SITEMAP" == "true" ]; then 
  echo "Pinging the world"
  bundle exec middleman sitemap_ping
fi

echo "Done"
