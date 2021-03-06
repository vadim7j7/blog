source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.5'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'

# Use ActiveModel has_secure_password
gem 'bcrypt'

# OAuth JSON Web Token standard
gem 'jwt'

# A simple, standardized way to build and use Service Objects
gem 'simple_command'

# ActiveRecord plugin allowing you to hide and restore records without actually deleting them.
gem 'paranoia'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS),
# making cross-origin AJAX possible
gem 'rack-cors'

# Rack middleware for blocking & throttling abusive requests
gem 'rack-attack'

# To Convert ActionModel to JSON
gem 'active_model_serializers'

# To setting some permissions
gem 'cancancan'

# A tagging plugin for Rails applications that allows for custom tagging along dynamic contexts.
gem 'acts-as-taggable-on'

# This is a pagination library that integrates with Ruby on Rails
gem 'will_paginate'

# Ancestry is a gem that allows the records of a Ruby on Rails ActiveRecord model
# to be organised as a tree structure
gem 'ancestry'

# Paperclip is intended as an easy file attachment library for ActiveRecord.
gem 'paperclip'


group :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'faker'

  # https://robots.thoughtbot.com/validating-json-schemas-with-an-rspec-matcher
  gem 'json-schema'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Storing configuration in a file
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
