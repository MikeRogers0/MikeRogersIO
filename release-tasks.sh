#!/bin/bash

echo "Running Release Tasks"
if [ "$INVALIDATE_CDN_AFTER_RELEASE" == "true" ]; then 
  echo "Invalidating CDN"
  bundle exec middleman cdn
fi

if [ "$PING_SITEMAP_AFTER_RELEASE" == "true" ]; then 
  echo "Pinging the world"
  bundle exec middleman sitemap_ping
fi

echo "Done"
