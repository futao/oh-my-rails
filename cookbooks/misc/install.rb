# @TODO获取项目名称

application "config.generators.assets = false"
application "config.generators.helper = false"
application "config.i18n.default_locale = 'zh-CN'"

generate "annotate:install"

create_file 'db/seeds/development/.keep'

create_file '.env' do
  <<-EOS.strip_heredoc
    export SECRET_KEY_BASE=example
  EOS
  # export #{app_name_env}_DATABASE_PASSWORD=example
end

append_to_file '.gitignore' do
  <<-EOS.strip_heredoc
    public/assets
    vendor/assets/bower_components
    .DS_Store
    erd.pdf
    rails_best_practices_output.html
  EOS
end
