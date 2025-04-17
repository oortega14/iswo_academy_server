source 'https://rubygems.org'

ruby '3.3.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'

# Use Prawn to create PDF's
gem 'prawn'

# Use Rubocop to check quality on code
gem 'rubocop'


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem 'image_processing', '~> 1.2'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem 'rack-cors'

# acts_as_list gem
gem 'acts_as_list'

# Authorization
gem 'pundit', '~> 2.5'

# pagination
gem 'pagy'

# Authentication
gem 'devise', '~> 4.9'
gem 'devise-jwt', '~> 0.12.1'

# Soft delete
gem 'paranoia'

# Excel reader
gem 'roo'

# CSV reader
gem 'csv'

# User Active storage S3
gem 'aws-sdk-s3', require: false

# Manager api responses
gem 'jsonapi_responses', '~> 0.1.2'

# Mercado Pago
gem 'mercadopago-sdk', '~> 2.3'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri windows ], require: 'debug/prelude'
  gem 'dotenv-rails'
  gem 'pry'
  gem 'pry-rails'

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem 'rubocop-rails-omakase', require: false

  gem 'letter_opener'
end
