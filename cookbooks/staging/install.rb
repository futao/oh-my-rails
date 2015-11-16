append_to_file 'config/database.yml' do
  <<-EOS.strip_heredoc

    staging:
      <<: *default
      database: #{app_path.basename}_staging
      username: #{app_path.basename}
      password: <%= ENV['#{app_path.basename.to_s.upcase}_DATABASE_PASSWORD'] %>
  EOS
end


append_to_file 'config/secrets.yml' do
  <<-EOS.strip_heredoc

    staging:
      secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
  EOS
end

copy_file File.expand_path('config/environments/production.rb', app_path),
          'config/environments/staging.rb'
