source 'https://rubygems.org'
ruby '2.2.0'

# PostgreSQL driver
gem 'pg'

# Sinatra driver
gem 'sinatra'
gem 'sinatra-contrib'

gem 'dotenv'
gem 'actionmailer'

gem 'activesupport', '~>4.1'
gem 'activerecord', '~>4.1'

gem 'rake'
gem 'shotgun'

gem 'bcrypt'
gem 'chartkick'

group :production do
  gem 'thin'
end

group :test do
  gem 'shoulda-matchers'
  gem 'rack-test'
  gem 'rspec'
end

group :test, :development do
  gem 'factory_girl'
  gem 'faker'
end
