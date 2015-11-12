require 'active_support/core_ext/string/indent.rb'
require 'active_support/core_ext/string/strip.rb'

cookbooks_path = File.expand_path('../cookbooks',__FILE__)

gem 'devise'
gem 'devise-i18n'
gem 'devise_invitable'

gem 'rails-i18n'
gem 'i18n-tasks', '0.8.7'
gem 'seedbank'
gem 'bower-rails'
gem 'sidekiq'
gem 'sinatra', :require => nil
gem 'puma'

gem 'kaminari'
gem 'slim-rails'
gem 'enumerize'
gem 'paranoia'
gem 'aasm'
gem 'awesome_nested_set'

gem_group :development do
  gem 'annotate'
  gem 'dotenv-rails'
  gem 'foreman'

  # Guard
  gem 'guard-bundler'
  gem 'guard-migrate'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rack-livereload'

  # Capistrano
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano3-puma'
  gem 'capistrano-sidekiq'

  # Other
  gem 'pry-rails'
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'rails-erd'
  gem 'letter_opener'
  gem 'brakeman'
  gem 'rails_best_practices'
  gem 'spring-commands-rspec'
end

gem_group :test do
  gem 'database_cleaner'
  gem 'shoulda'
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'launchy'
end

after_bundle do
  run "bundle exec spring binstub --remove --all"
  rake 'db:create'
  rake 'db:migrate'
  git :init
  git add: '.'
  git commit: %q{ -m 'Initial commit'}

  %w{
    misc
    bower_rails  kaminari guard rspec
    i18n_task sidekiq capistrano devise foreman
  }.each do |recipe|
    current_recipe_path = File.join(cookbooks_path, recipe , 'install.rb')
    rake "rails:template LOCATION=#{current_recipe_path}"
    git add: '.'
    git commit: %Q< -m 'Add #{recipe.upcase}' >
  end

  run "bundle exec spring binstub  --all"
  git :init
  git add: '.'
  git commit: %q{ -m 'Setup Spring'}

  rake 'tmp:create'
  run "bundle exec launchy http://127.0.0.1:3000/welcome/index"
  run "bundle exec foreman start"
end
