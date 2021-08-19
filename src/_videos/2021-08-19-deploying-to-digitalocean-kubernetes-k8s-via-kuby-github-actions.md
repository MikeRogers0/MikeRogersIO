---
layout: video
title: Deploying to DigitalOcean Kubernetes (k8s) via Kuby & GitHub Actions
youtube_id: AiC1q7K0bBE
published_at: '2021-08-19T10:30:04+00:00'
---
Deploying Ruby on Rails to a Kubernetes cluster can lead to YAML hell, however Kuby ( https://getkuby.io/ ) makes this a lot easier by extracting most the complexity away. It's super cool!

In this tutorial, we're going to configure Kuby to deploy to DigitalOcean with a Managed Database, which will redeploy every time we push to GitHub.

# Sources

➡ https://getkuby.io/
➡ https://getkuby.io/docs/
➡ https://github.com/MikeRogers0-YouTube/Deploying-With-Kuby
➡ https://github.com/MikeRogers0-YouTube/Deploying-With-Kuby/blob/main/kuby.rb - The Kuby Configuration
➡ https://github.com/MikeRogers0-YouTube/Deploying-With-Kuby/blob/main/.github/workflows/deploy.yml - The GitHub Action
➡ https://cloud.digitalocean.com/

# Chapters

0:00 -  What are we going to do
0:53 - What I setup beforehand
1:36 - Adding the gem & running the generator
2:58 - Generate Rails credentials
4:24 - Setting DigitalOcean API Token for Docker
5:40 - Setting image_url to point to container registry
6:15 - The Kubernetes block
7:47 - Setting the DATABASE_URL
8:48 - Configuring the provider
9:54 - Refactor a little
10:20 - bundle exec kuby -e production setup
11:26 - Deploy with a GitHub Action
14:42 - It's Deployed

# Follow Me Online

➡ Blog: https://mikerogers.io/
➡ Twitter: https://twitter.com/MikeRogers0
➡ GitHub: https://github.com/mikerogers0
➡ YouTube: https://www.youtube.com/c/MikeRogers0
➡ BuyMeACoffee: https://www.buymeacoffee.com/MikeRogers0
➡ Dev.to: https://dev.to/mikerogers0

#RubyOnRails #AwesomeRubyGems #Kubernetes #Kuby #k8s