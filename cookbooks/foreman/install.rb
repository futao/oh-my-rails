create_file 'Procfile' do
  <<-EOD.strip_heredoc
    web: bundle exec rails s puma -b 0.0.0.0
    sidekiq: bundle exec sidekiq -C config/sidekiq.yml
  EOD
end
