source 'https://rubygems.org'
ruby "2.3.1"

gem 'rails', '~>4.2'

gem 'angular-rails-templates', '0.2.0'
gem 'bower-rails'
gem "cancancan"
gem 'capistrano', '~> 3.4.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'coffee-rails', '~> 4.1.0'
gem 'dotenv-rails', groups: [:development, :test]
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem "jquery-slick-rails"
gem 'jbuilder', '~> 2.0'
gem 'magnific-popup-rails'
gem "mini_magick"
gem 'sdoc', '~> 0.4.0', group: :doc
gem "paperclip", github: "thoughtbot/paperclip", ref: "c38bb31"
gem 'pg', '~> 0.15'
gem 'rubyntlm', '~> 0.6.0'
gem 'sass-rails', '~> 5.0'
gem 'savon'
gem 'uglifier', '>= 1.3.0'



# Add this if you're using rbenv
gem 'capistrano-rbenv', github: "capistrano/rbenv"
# Spree needs this version at the moment
gem 'mail', '2.5.4'



group :test, :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem "rspec-rails", '~> 3.0'
  gem "factory_girl_rails", "~> 4.0"
  gem 'teaspoon-jasmine'
  gem 'phantomjs'
end


group :test do
  gem "capybara"
  gem "database_cleaner"
  gem 'ffaker'
  gem "guard-rspec", require: false
  gem 'launchy'
  gem "selenium-webdriver"
end



group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

gem 'aws-sdk'
gem 'datashift', '~> 0.15'
gem 'datashift_spree'#, github: 'autotelik/datashift_spree', branch: 'master'
gem 'spree', '~> 3.1.0'
gem 'spree_auth_devise', '~> 3.1.0'
gem 'spree_gateway', '~> 3.1.0'
gem 'spree_simple_sales', path: '../../spree_simple_sales'