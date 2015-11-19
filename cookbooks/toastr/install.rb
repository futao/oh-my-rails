# 弹出式消息提示框
append_to_file 'Bowerfile', "\nasset 'toastr'"
rake 'bower:install'

append_to_file 'app/assets/javascripts/admin_lte.js',
               "\n//= require toastr"

insert_into_file 'app/assets/stylesheets/admin_lte.css', "*= require toastr\n",
                 before: '*/'
