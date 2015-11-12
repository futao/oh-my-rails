application  "config.active_job.queue_adapter = :sidekiq"

prepend_to_file 'config/routes.rb', "require 'sidekiq/web'\n"

route "mount Sidekiq::Web => '/sidekiq'"

create_file "config/sidekiq.yml" do
  <<-EOD.strip_heredoc
    :concurrency: 5
    :pidfile: tmp/pids/sidekiq.pid
    staging:
      :concurrency: 10
    production:
      :concurrency: 20
    :queues:
      - default
  EOD
end
