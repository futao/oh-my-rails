require 'active_support/core_ext/string/indent.rb'
require 'active_support/core_ext/string/strip.rb'



gem 'devise'
gem 'devise-i18n'
gem 'devise_invitable'

gem 'kaminari'
gem 'kaminari-i18n'

gem 'rails-i18n'
gem 'seedbank'
gem 'bower-rails'
gem 'sidekiq'
gem 'sinatra', :require => nil
gem 'puma'
gem 'friendly_id'
gem 'ruby-pinyin'

gem 'slim-rails'
gem 'enumerize'
gem 'paranoia'
gem 'aasm'
gem 'awesome_nested_set'

gem_group :development do
  gem 'annotate'
  gem 'dotenv-rails'
  gem 'foreman'
  gem 'i18n-tasks', '0.8.7'

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
  gem 'capistrano-sidekiq',  '0.5.3'

  # Rspec
  gem 'spring-commands-rspec'

  # Debug
  gem 'pry-rails'
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'rails-erd'


  # Code Analytics
  gem 'brakeman'
  gem 'rails_best_practices'

  # Mail
  gem 'letter_opener'
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
  git commit: %q{ -m 'oh-my-rails: initial commit'}

  cookbooks_path = File.expand_path('../cookbooks',__FILE__)

  %w{
    misc staging email rspec i18n capistrano
    bower_rails  kaminari guard  devise friendly_id
    sidekiq   adminlte
    generator_overrides shared_partials
    moment nprogress toastr
  }.each do |recipe|
    current_recipe_path = File.join(cookbooks_path, recipe , 'install.rb')
    rake "rails:template LOCATION=#{current_recipe_path}"
    git add: '.'
    git commit: %Q< -m 'oh-my-rails: add #{recipe.downcase}' >
  end

  run "bundle exec spring binstub  --all"
  git :init
  git add: '.'
  git commit: %q{ -m 'oh-my-rails: setup spring'}

  # special
  current_recipe_path = File.join(cookbooks_path, 'github' , 'install.rb')
  rake "rails:template LOCATION=#{current_recipe_path}"

  rake 'tmp:create'
  run "bundle exec launchy http://127.0.0.1:3000"
  run "bundle exec foreman start"
end
