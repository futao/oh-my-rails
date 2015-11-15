application  "config.active_job.queue_adapter = :sidekiq"

prepend_to_file 'config/routes.rb', "require 'sidekiq/web'\n"

route "mount Sidekiq::Web => '/sidekiq'"

copy_file File.expand_path('../sidekiq.yml',__FILE__), 'config/sidekiq.yml'

append_to_file 'Procfile', "sidekiq: bundle exec sidekiq -C config/sidekiq.yml\n"
