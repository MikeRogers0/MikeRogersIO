#!/usr/bin/env bash
# Taken from https://docs.netlify.com/configure-builds/file-based-configuration/#inject-environment-variable-values

CSS_PATH=`find build/_bridgetown/static/css/*.css -type f | sed -e 's/build\///g'`

sed -i s/NETLIFY_IMAGES_CDN_DOMAIN/${NETLIFY_IMAGES_CDN_DOMAIN}/g netlify.toml
sed -i s/SITE_ID/${SITE_ID}/g netlify.toml
sed -i s/CSS_PATH/${CSS_PATH}/g netlify.toml
