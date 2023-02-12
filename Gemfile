source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "bootsnap", require: false
gem "bootstrap_form"
gem "cssbundling-rails"
gem "devise"
gem "fast_jsonparser"
gem "haml-rails"
gem "http"
gem "importmap-rails"
gem "jbuilder"
gem "jsbundling-rails"
gem "pg"
gem "puma"
gem "rails", "~> 7.0.4"
gem "sassc-rails"
gem "sentry-rails"
gem "sentry-ruby"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem

group :development do
  gem "html2haml"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "webdrivers"
  gem "webmock"
end

group :development, :test do
  gem "brakeman"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "pry"
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
end
