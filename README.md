[![Build Status](https://travis-ci.org/MikeRogers0/MikeRogersIO.svg?branch=master)](https://travis-ci.org/MikeRogers0/MikeRogersIO)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/df7d23ccf98c47179b1eec1d72568785)](https://app.codacy.com/app/MikeRogers0/MikeRogersIO?utm_source=github.com&utm_medium=referral&utm_content=MikeRogers0/MikeRogersIO&utm_campaign=Badge_Grade_Dashboard)
[![Maintainability](https://api.codeclimate.com/v1/badges/6f1ddb38ace46bf6ff07/maintainability)](https://codeclimate.com/github/MikeRogers0/MikeRogersIO/maintainability)

# MikeRogers.io

My personal website which shows off bits of my portfolio and ramblings from my blog. Yay

## Deploying

```bash
cap production deploy
```

### Deploy Setup

```bash
cap production puma:config
cap production puma:nginx_config
```

## Running the specs

```bash
bundle exec rspec
```
