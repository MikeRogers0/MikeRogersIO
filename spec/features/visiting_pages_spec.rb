require 'spec_helper'

feature 'Visiting Pages' do
  [
    '/',
    '/portfolio.html',
    '/posts.html',
    '/2019/05/20/testing-rails-action-mailbox-with-rspec.html'
  ].each do |page_route|
    scenario "#{page_route} load successfully" do
      visit page_route
      expect(page.status_code).to eq(200)
    end
  end
end
