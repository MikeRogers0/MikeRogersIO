#!/bin/bash

echo "Running Release Tasks"
if [ "$INVALIDATE_CDN_AFTER_RELEASE" == "true" ]; then 
  echo "Invalidating CDN"
  bundle exec middleman cdn
fi

echo "Done"
