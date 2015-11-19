# 进度条显示插件
append_to_file 'Bowerfile', "\nasset 'nprogress'"
rake 'bower:install'

append_to_file 'app/assets/javascripts/admin_lte.js',
               '//= require nprogress'

insert_into_file 'app/assets/stylesheets/admin_lte.css', "*= require nprogress\n",
                 before: '*/'
