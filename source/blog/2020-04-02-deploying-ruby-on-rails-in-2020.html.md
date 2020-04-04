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

_TL;DR: Heroku is still hands downs my preferred choice for hosting & deployment in 2020. Digital Ocean is my other preferred option._

Hosting & deploying a modern Ruby on Rails application is an adventure! The options available are constantly evolving & a lot of it feels like magic.

I decided to experiment a few the popular approaches over the last week & see what state of Ruby on Rails deployment was in 2020.

I setup a simple Rails app which had the following fairly common requirements:

* Assets imported via Yarn
* Background jobs being performed via Sidekiq
* Database migrations to be run as part of deployment
* Easily scaleable
* Deployment can be automated after a test suite passes
* Databases, Redis & file uploads are managed on an external service like AWS RDS & S3.

For automated deployments I'd use what integrations they offered, if they didn't offer an easy integration I setup a script via a Github Action to perform the deployment.

## PaaS

Platform as a Service has been my preferred hosting choice for most my professional career. They normally handle patching of the server software, so I just have to provide my apps code & they do the rest, it's awesome.

### Heroku

I've used Heroku as my go to solution for the last few years. For a while it had a repetition as being quite expensive, but now that they have a tier which starts as $7 a month they are very affordable.

Setting up my app was just a matter of connecting my account to the GitHub Repository & clicking "Deploy". Automating deploys was pretty painless as I just had a to check a box in their very clear web UI.

I liked that the pricing is fairly obvious. I could easily see how much I was spending & scale easily. The only drawback I've found is that autoscaling is only available for the higher end tiers.

### AWS Elastic Beanstalk

I really want to rip Beanstalk for being classily AWS "Here is a product...good luck". But annoyingly it's one of the best products for getting a Ruby on Rails online within the AWS Environment.

Beanstalk is pretty cheap & you have a lot of options for what kind of severs you'd like, which is nice. You can also setup autoscaling without to much kerfuffle via their Web UI, though if you're unfamiliar with AWS it might feel a little intimidating at first.

To be able to run both Rails & Sidekiq comfortably within my Beanstalk setup, I used their ["Multicontainer Docker environments"](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_docker_ecs.html). I pretty much just setup a `Dockerrun.aws.json` (which feels a lot like `docker-compose.yml`), then was good to go.

Setting up a simple CI system was pretty straight forward. Historically I was able to deploy via terminal, but I found a nice [GitHub Action](https://github.com/marketplace/actions/beanstalk-deploy) which saved a lot of headaches.

Figuring out the pricing of Beanstalk is a little tricky, like all AWS products they don't show you an estimate of cost at the point of sale.

I need to do a full write-up about getting online with AWS Elastic Beanstalk, I think it's a great tool but it takes a bit of googling to get your initial setup feeling correct.

### Google App Engine

Getting up and going was pretty straight forward. They had a fairly [clear guide](https://cloud.google.com/ruby/rails/using-cloudsql-postgres) to get going from my local terminal, which looked fairly easily to translate to a GitHub Action if I wanted to deploy in an automated fashion.

Out of the box the pricing was a little unclear (I had to use the [Google Cloud Platform Pricing Calculator](https://cloud.google.com/products/calculator/) to figure out the monthly cost). But once I started running some numbers it felt like it could very easily become quite expensive if I wasn't actively monitoring my application.

One disappointing drawback was managing Environment Variables. If I wanted to store any API keys, I had to commit them to version control or [inject them while deploying](https://dev.to/mungell/google-cloud-app-engine-environment-variables-5990). I only scratched the surface, so there might be a better solution out there, but I couldn't find it.

### Azure App Service

I was quite impressed by Azure, it had a UI which made getting setting fairly easy. Out of the box it didn't support Ruby, but if you're using Docker this isn't an issue. I also found a [Github Actions template](https://github.com/Azure/actions-workflow-samples/blob/master/AppService/docker-webapp-container-on-azure.yml) for deploying which was nice.

Like Google App Engine running migrations around the deploy process wasn't the most obvious thing to setup. When searching for the best way to solve this issue, I kept finding results for the "App Service Migration Assistant" which made finding information about database migrations somewhat tricky.

## Kubernetes

Every time I've historically used Kubernetes on my local machine, I found it would drain my battery super fast, so I've always been a little put off by it. However, I'm seeing it appear in job descriptions so I thought I should give it a try.

Most cloud providers (AWS, Azure, Google & Digital Ocean) each provide a Kubernetes product. I ended up doing most of my experimenting with Digital Ocean as they had the most clear pricing.

I found the initial learning curve of Kubernetes quite steep. Luckily I found [Kompose](https://kompose.io/) which is a tool that makes moving from docker-compose to Kubernetes a little easier. I also found a nice [sample setup with a GitHub Action](https://github.com/do-community/example-doctl-action) for deploying to Digital Ocean, which made deploying more approachable.

Overall I felt Kubernetes was a nice solution for apps that required lots of services to operate correctly. 

Overall Kubernetes seemed like a good solution for once your project out grows Heroku (e.g. you're spending more then the cost of a Devops specialist per a month on servers). I'd recommend using it via Convox or Cloud 66 Maestro initially as it can be a little fiddly to configure.

## Single Server

### Dokku

Dokku is kind of like Heroku, but if you wanted to run your app on a single server. It's pretty nice over using Capistrano on a single server as it handles a good amount of the extra configuration for you.

I liked how simple the [GitHub Action for Dokku Deploying](https://github.com/marketplace/actions/dokku-to-deploy) looked, you're pretty much just pushing your code via git to your server & letting it do the rest.

It's a little unclear how Dokku will scale once you reach the limitation of your server (Other then increasing your single servers resources), but it does seem quite suitable for solo side projects.

### Capistrano + Virtual Private Server

I've had a few side projects that I had running on AWS Lightsail which I deployed with Capistrano in the past. It's super nice to run when you only want to run a Rails app for less than $5 a month. There are even [GitHub Actions](https://github.com/marketplace/actions/capistrano-deploy) to automate deployments.

I don't use Capistrano to often any more as it requires setting up & _maintaining_ of servers. I really discourage developers from burdening themselves with server administration, as it's a large time sink which can be avoided by using a platform which removes this need.

## Managed Servers

### Convox

Convox is a really nice concept. You connect your AWS, Digital Ocean, Google Cloud or Azure account & they'll manage a Kubernetes stack for you. Then you connect your GitHub Repository and they'll handle deployments, all configured via a simple [`convox.yml`](https://docs.convox.com/configuration/convox-yml) file.

It didn't take me to long to get an app up and running on AWS which was nice, however deploying the same app to Digital Ocean didn't quite work as smoothly. When I emailed their support enquiring what was wrong I didn't get a response.

I really wanted to recommend when I first started using it, but I think it needs more polish for me to recommend it as a solution for everyone.

### Cloud 66

I used Cloud 66 in the past (Both their Maestro & classic Ruby on Rails offerings). It's a nice service & being able to connect a codebase, the just deploy it out to your AWS account is enjoyable.

Their classic Ruby on Rails offerings is pretty quick to get going with, but as you scale up in servers will start to feel expensive. I'm also a little sceptical what they do to maintain servers.

I'd suggest only using their Maestro product, as it's a bit like Convox, where they simplify Kubernetes into a single configuration file.

