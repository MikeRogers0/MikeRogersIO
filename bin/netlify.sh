#!/usr/bin/env bash
# Taken from https://docs.netlify.com/configure-builds/file-based-configuration/#inject-environment-variable-values

echo "Updating netlify.toml with references to our built files"

CSS_PATH=`find build/_bridgetown/static/css/*.css -type f | sed -e 's,build\/,/,g'`

echo "CSS Path: ${CSS_PATH}"

sed -i s,SITE_URL,${URL},g netlify.toml
sed -i s,CSS_PATH,${CSS_PATH},g netlify.toml
sed -i s,NETLIFY_IMAGES_CDN_DOMAIN,${NETLIFY_IMAGES_CDN_DOMAIN},g netlify.toml
