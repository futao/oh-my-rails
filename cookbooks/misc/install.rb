app_name = ARGV[1].to_s
app_name_env = app_name.upcase

application "config.generators.assets = false"
application "config.generators.helper = false"
application "config.i18n.default_locale = 'zh-CN'"
application "config.active_record.default_timezone = :local"
application "config.time_zone = 'Beijing'"

generate "annotate:install"

create_file 'db/seeds/development/.keep'

create_file '.env' do
  <<-EOS.strip_heredoc
    export SECRET_KEY_BASE=example
    export #{app_name_env}_DATABASE_PASSWORD=example
  EOS
end

append_to_file '.gitignore' do
  <<-EOS.strip_heredoc
    public/assets
    vendor/assets/bower_components
    .DS_Store
    erd.pdf
  EOS
end
