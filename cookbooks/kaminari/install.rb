generate "kaminari:config"
directory File.expand_path('../bootstrap3', __FILE__), 'app/views/kaminari'
copy_file File.expand_path('../kaminari.yml', __FILE__),
          'config/locales/kaminari.yml'
