generate 'bower_rails:initialize'
rake 'bower:install'

insert_into_file 'Capfile', :after => "# require 'capistrano/passenger'\n" do
  <<-EOD.strip_heredoc
    # https://github.com/platanus/capistrano-bower
    require 'capistrano/bower'
  EOD
end
