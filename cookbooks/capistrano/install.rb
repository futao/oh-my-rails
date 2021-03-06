run "cap install"
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


gsub_file 'config/deploy.rb', "'my_app_name'", "'#{app_path.basename}'"
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
