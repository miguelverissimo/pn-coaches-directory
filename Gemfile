source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'jbuilder', '~> 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'rack-attack'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'puma'

group :production do
  gem "passenger", ">= 5.3.2", require: "phusion_passenger/rack_handler"
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
  gem 'pry'
  gem 'rspec-rails'
  gem 'ffaker'
  gem 'factory_bot_rails'
end

group :development do
  gem 'annotate'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-passenger'
  gem 'capistrano-puma', require: false
end

