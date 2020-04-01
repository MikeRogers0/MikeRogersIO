---
layout: post
title: Deploying your Ruby on Rails in 2020
categories:
 – blog
published: true
meta:
  description: So many options?! But which is the best all round.
  index: true
---

_TL;DR: Heroku is still hands downs my preferred choice for Rails hosting in 2020. Digital Ocean is my other preferred option._

Deploying modern web applications is one of the constant learning curves I've encountered over the last few years. Every solution is subtly different & it always feels like an ever evolving world.

I decided to experiment all the popular approaches over the last week & see what state of deployment was in 2020. For this I setup a simple Rails app which had the following fairly common requirements:

* Assets imported via Yarn
* Background jobs being performed via Sidekiq
* Database migrations to be run as part of deployment
* Easily scaleable
* Deployment can be automated after tests pass.

If they didn't offer a GitHub integration for deployment, I attempted to automated the deploy via Github Actions instead.

## Heroku 👍

Cost per a month: $14

I've used Heroku as my go to solution for the last few years. For a while it had a repetition as being quite expensive, but now they have a tier which starts as $7 a month, which makes them very affordable.

Setting up my app was just a matter of connecting my account to the GitHub Repository & clicking "Deploy". Automating deploys was pretty painless as I just had a to check a box in their very clear web UI.

I liked that the pricing is fairly obvious. I could easily see how much I was spending & scale easily. The only drawback I've found is that Autoscaling is only available for the higher end tiers.

## Google App Engine 👍

Cost per a month: $50

Getting up and going was pretty straight forward. They had a fairly [clear guide](https://cloud.google.com/ruby/rails/using-cloudsql-postgres) to get going from my local terminal, which looked fairly easily to translate to a GitHub Action if I wanted to deploy in an automated fashion.

Out of the box the pricing was a little unclear (I had to use the [Google Cloud Platform Pricing Calculator](https://cloud.google.com/products/calculator/) to figure out the monthly cost). But once I started running some numbers it felt like it could very easily become quite expensive if I wasn't actively monitoring my application.

One disappointing drawback was managing Environment Variables. If I wanted to store any API keys, I had to commit them to version control or [inject them while deploying](https://dev.to/mungell/google-cloud-app-engine-environment-variables-5990). I only scratched the surface, so there might be a better solution out there, but I couldn't find it.

## Kubernetes on Digital Ocean 👍

Still trying this one out.

## Convox 👎

Convox is a really nice concept. You connect your AWS, Digital Ocean, Google Cloud or Azure account & they'll setup a Kubernetes stack for you. Then you connect your GitHub Repository and they'll handle deployments, all configured via a simple `convox.yml` file.

It didn't take me to long to get an app up and running on AWS which was nice, however deploying the same app to Digital Ocean didn't quite work as smoothly. When I emailed their support enquiring what was wrong, I didn't get a response.

I really wanted to recommend when I first started using it, but it felt a bit of a 

## RedHat OpenShift 👎

I couldn't figure out the [pricing](https://www.openshift.com/products/pricing/) on their pricing page. So I skipped over this option.
