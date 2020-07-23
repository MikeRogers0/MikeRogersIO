require 'octokit'

module Source
  class GithubPullRequests < Base
    def latest_entries
      @latest_entries ||= issues.reject(&:private?).map { |entry| Entry.new(entry) }
    end

    def issues
      client.search_issues('is:merged is:pr author:MikeRogers0 archived:false state:closed', { s: :created }).items
    end

    def client
      @client ||= Octokit::Client.new(auto_paginate: true)
    end

    def filename
      "github_pull_requests.yml"
    end

    def distinct_filename
      "distinct_github_pull_requests.yml"
    end

    class Entry
      def initialize(github_data)
        @github_data = github_data
      end

      def to_h
        {
          'title' => title,
          'number' => number,
          'url' => url,
          'repository_url' => repository_url,
          'repository' => repository,
          'created_at' => created_at,
          'created_on' => created_on
        }
      end

      def title
        @github_data.title
      end

      def number
        @github_data.number
      end

      def url
        @github_data.html_url
      end

      def repository_url
        @github_data.repository_url.sub('https://api.github.com/repos/', 'https://www.github.com/')
      end

      def repository
        @github_data.repository_url.sub('https://api.github.com/repos/', '')
      end

      def created_at
        Time.at(@github_data.created_at).to_s
      end

      def created_on
        Time.at(@github_data.created_at).to_date.to_s
      end
    end
  end
end
