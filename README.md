![alt text](https://s3-ap-southeast-1.amazonaws.com/porthos/public/assets/logo/favicon.ico "Logo") Porthos Home Furniture Website Documentation
======

The website can be found here: [https://porthoshome.com/](https://porthoshome.com/)





## This documents the `master` branch of this project

* [- Architecture / Setup / Configuation](https://github.com/porthoshome/storefront#setup)
* [- Gems](https://github.com/porthoshome/storefront#gems "Installed Gems")



## Setup
This site is intended to be an e-commerce site in the future. 
For this reason the site is built on and runs on **spreecommerce version 3-1 stable**.
Test coverage is limited to the features not already tested as part of the [Spree Commerce](https://github.com/spree/spree) engine.

Other import parts of the architecture are:

- Project Tracking: https://tree.taiga.io/project/setclockpm-porthos-home/
- Hosting: **DigitalOcean**
- **Nginx** on **Ubuntu 14.04**
- Asset(s): **Amazon AWS / S3**
- Database: **PostgreSQL 9.4**
- Rails: 4.2
- Ruby: 2.3.1, managed using rbenv
- Package Managers: Rubygems, Bower
- Deployment: Capistrano 3.4


## Gems


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
    gem "paperclip", git: "https://github.com/thoughtbot/paperclip.git", ref: "c38bb31"
    gem 'pg', '~> 0.15'
    gem "recaptcha", require: "recaptcha/rails"
    gem 'rubyntlm', '~> 0.6.0'
    gem 'sass-rails', '~> 5.0'
    gem 'savon'
    gem 'uglifier', '>= 1.3.0'
    gem 'capistrano-rbenv', '~> 2.0'
    gem 'mail', '~> 2.6.0'
    
    
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
    gem 'spree_i18n', git: 'https://github.com/spree-contrib/spree_i18n.git', branch: '3-1-stable'
    gem 'spree_globalize', git: 'https://github.com/spree-contrib/spree_globalize.git/', branch: 'master'
    gem 'spree_simple_sales', path: '../../spree_simple_sales'
