generate 'bower_rails:initialize'
rake 'bower:install'

copy_file File.expand_path('../templates/bower.rake',__FILE__),
        'lib/capistrano/tasks/bower.rake'

insert_into_file 'config/deploy.rb', :after=>"namespace :deploy do\n" do
  %q{before 'deploy:compile_assets', 'bower:install'}.indent(2)
end
