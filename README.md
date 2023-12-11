# README


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

Install native extension: gem install mysql2;

Gemfile: 
In development and test group add: gem 'rspec-rails';

Uncomment rack-cors for handling Cross-Origin Resource Sharing (CORS);

Add jwt gem globally in Gemfile : gem 'jtw';

Add debugger for development:
group :development do
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-nav'
;

***Remember to execute bundle install after adding this gem in the Gemfile***

* Configuration

Commands to create the api rails: rails new my_sql_app --api -d mysql;

Add in config/application.rb inside class Application: 
    config.generators do |generator|
      generator.test_framework(:rspec, fixtures: false)
    end
;

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
