namespace :deploy do
  namespace :middleman do
    desc 'Build site on the server'
    task :build do
      on roles(:web) do
        within release_path do
          execute :bundle, 'exec middleman build'
        end
      end
    end
  end

  after 'deploy:updated', 'deploy:middleman:build'

  desc "Once we've deployed, clear CloudFront"
  task :invalidating_cdn do
    on roles(:web) do
      within release_path do
        execute :bundle, 'exec middleman cdn'
      end
    end
  end
  # after 'deploy:finished', 'deploy:invalidating_cdn'

  desc 'Ping the various sitemap providers'
  task :sitemap_ping do
    on roles(:web) do
      within release_path do
        execute :bundle, 'exec middleman sitemap_ping'
      end
    end
  end
  # after 'deploy:finished', 'deploy:sitemap_ping'
end
