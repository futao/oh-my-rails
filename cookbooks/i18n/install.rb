remove_file 'config/locales/en.yml'
application "config.i18n.default_locale = 'zh-CN'"
directory File.expand_path('../templates', __FILE__),
                  'config/locales'

run "cp $(i18n-tasks gem-path)/templates/config/i18n-tasks.yml config/"
run "cp $(i18n-tasks gem-path)/templates/rspec/i18n_spec.rb spec/"
