generate 'bower_rails:initialize'
rake 'bower:install'

uncomment_lines 'config/initializers/bower_rails.rb', /resolve_before/
copy_file File.expand_path('../templates/bower.rake',__FILE__),
          'lib/capistrano/tasks/bower.rake'

insert_into_file 'config/deploy.rb', :after=>"namespace :deploy do\n" do
  %q{before 'deploy:compile_assets', 'bower:install'}.indent(2)
end
