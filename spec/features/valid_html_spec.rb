require 'spec_helper'

feature 'Valid HTML' do
  [
    '/',
    '/portfolio.html',
    '/posts.html',
    '/2019/05/20/testing-rails-action-mailbox-with-rspec.html'
  ].each do |page_route|
    scenario "#{page_route} has valid HTML" do
      visit page_route
      expect(page).to have_valid_html
    end
  end
end
