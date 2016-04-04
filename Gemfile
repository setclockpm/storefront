source 'https://rubygems.org'
ruby "2.3.0"

gem 'rails', '4.2.5.1'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'angular-rails-templates', '0.2.0'
gem 'bower-rails'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'paperclip'
gem "cancancan"
gem 'capistrano', '~> 3.4.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'

# Add this if you're using rbenv
gem 'capistrano-rbenv', github: "capistrano/rbenv"
# Spree needs this version at the moment
gem 'mail', '2.5.4'
gem 'wasabi'



group :test, :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'ffaker', '1.22.1'
  gem "rspec-rails", "~> 2.0"
  gem "factory_girl_rails", "~> 4.0"
  gem "capybara"
  gem "database_cleaner"
  gem 'launchy'
  gem "selenium-webdriver"
  gem 'teaspoon-jasmine'
  gem 'phantomjs'
end

# Heroku specific
gem "foreman"
group :production, :staging do
  
end



group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end


gem 'spree', '~> 3.0.8'
gem 'spree_gateway', '~> 3.0.0'
gem 'spree_auth_devise', '~> 3.0.0'