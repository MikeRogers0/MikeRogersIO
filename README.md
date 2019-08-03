# MikeRogers.io ##

My personal website which shows off bits of my portfolio and ramblings from my blog.

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
brew install tidy-html5
bundle exec rspec
```
