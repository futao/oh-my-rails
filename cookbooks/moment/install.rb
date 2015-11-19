append_to_file 'Bowerfile', "\nasset 'moment'"
rake 'bower:install'

append_to_file 'app/assets/javascripts/admin_lte.js' do
  <<-EOS.strip_heredoc
  //= require moment
  //= require moment/locale/zh-cn
  //= require plugins/moment
  EOS
end

copy_file File.expand_path('../moment.coffee', __FILE__),
            'app/assets/javascripts/plugins/moment.coffee'
