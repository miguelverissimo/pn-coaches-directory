source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'hiredis'
gem 'jbuilder', '~> 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'rack-attack'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'redis'

group :production do
  gem 'passenger', '>= 5.3.2', require: 'phusion_passenger/rack_handler'
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry'
  gem 'pry-byebug'
  gem 'puma'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'capistrano'
  gem 'capistrano-passenger'
  gem 'capistrano-puma', require: false
  gem 'capistrano-rails'
  # gem 'capistrano-rbenv'
  gem 'capistrano-asdf'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'mutant-rspec'
  gem 'rubocop'
  gem 'rubocop-rails'
end
