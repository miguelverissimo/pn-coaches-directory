source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'jbuilder', '~> 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'rack-attack'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# gem 'puma', '~> 4.1'
gem "passenger", ">= 5.3.2", require: "phusion_passenger/rack_handler"
# gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-passenger'
  gem 'capistrano-puma', require: false
end

group :test do
  gem 'factory_bot_rails'
end

