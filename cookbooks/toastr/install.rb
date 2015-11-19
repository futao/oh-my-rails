append_to_file 'Bowerfile', "\nasset 'toastr'"
append_to_file 'app/assets/javascripts/admin_lte.js',
               '//= require toastr'
insert_into_file 'app/assets/stylesheets/admin_lte.css', "*= require toastr\n",
                 before: '*/'
