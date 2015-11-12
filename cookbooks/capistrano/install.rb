uncomment_lines 'Capfile', /require.*rbenv/
uncomment_lines 'Capfile', /require.*bundle/
uncomment_lines 'Capfile', /require.*rails/

insert_into_file 'Capfile', :after => "# require 'capistrano/passenger'\n" do
  <<-EOD.strip_heredoc
    # https://github.com/seuros/capistrano-puma
    require 'capistrano/puma'
    require 'capistrano/puma/nginx'
    # https://github.com/seuros/capistrano-sidekiq
    require 'capistrano/sidekiq'
  EOD
end

uncomment_lines 'config/deploy.rb', /ask\s:branch/
uncomment_lines 'config/deploy.rb', /set\s:linked_dirs/
insert_into_file 'config/deploy.rb',
          :after=>"# set :deploy_to, '/var/www/my_app_name'\n" do
  %q<set :deploy_to, "/var/www/#{fetch(:application)}/#{fetch(:stage)}">
end

insert_into_file 'config/deploy.rb', :after=> "# set :keep_releases, 5\n" do
  <<-EOD.strip_heredoc

    # https://github.com/capistrano/rbenv
    set :rbenv_type, :system # or :user, depends on your rbenv setup
    set :rbenv_ruby, '2.2.2'
    set :rbenv_prefix, "RBENV_ROOT=\#{fetch(:rbenv_path)} RBENV_VERSION=\#{fetch(:rbenv_ruby)} \#{fetch(:rbenv_path)}/bin/rbenv exec"
    set :rbenv_map_bins, %w{rake gem bundle ruby rails}
    set :rbenv_roles, :all # default value

    # https://github.com/capistrano/bundler
    set :bundle_jobs, 4 # default: nil, only available for Bundler >= 1.4
  EOD
end

create_file 'lib/capistrano/tasks/bower.rake' do
  <<-EOD.strip_heredoc
    namespace :bower do
      desc 'Install bower'
      task :install do
        on roles(:web) do
          within release_path do
            with rails_env: fetch(:rails_env) do
              execute :rake, 'bower:install CI=true'
            end
          end
        end
      end
    end
  EOD
end

insert_into_file 'config/deploy.rb', :after=>"namespace :deploy do\n" do
  %q{before 'deploy:compile_assets', 'bower:install'}.indent(2)
end

append_to_file 'config/database.yml' do
  <<-EOS.strip_heredoc

    staging:
      <<: *default
      database: #{app_name}_staging
      username: #{app_name}
      password: <%= ENV['FENG_HRS_01_DATABASE_PASSWORD'] %>
  EOS
end

append_to_file 'config/secrets.yml' do
  <<-EOS.strip_heredoc

    staging:
      secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
  EOS
end

# @TODO problem?
copy_file 'config/environments/production.rb',
          'config/environments/staging.rb'
