remove_file 'config/locales/en.yml'
run "cp $(i18n-tasks gem-path)/templates/config/i18n-tasks.yml config/"
run "cp $(i18n-tasks gem-path)/templates/rspec/i18n_spec.rb spec/"
