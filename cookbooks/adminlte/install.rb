if yes?('是否安装 AdminLTE 模板(Y/n)')
  append_to_file 'Bowerfile' do
    <<-EOS.strip_heredoc

    asset "admin-lte"
    EOS
  end
  rake 'bower:install'

  # 图片
  directory File.expand_path('../images', __FILE__), 'app/assets/images/admin_lte'

  # 局部模板
  directory File.expand_path('../shared', __FILE__), 'app/views/shared/admin_lte'

  # 布局模板
  copy_file File.expand_path('../admin_lte.html.erb', __FILE__),
              'app/views/layouts/admin_lte.html.erb'


  # js
  create_file 'app/assets/javascripts/admin_lte.js' do
    <<-EOS.strip_heredoc
      //= require jquery
      //= require jquery_ujs
      //= require admin-lte/bootstrap/js/bootstrap
      //= require admin-lte/dist/js/app
    EOS
  end

  # css
  create_file 'app/assets/stylesheets/admin_lte.css' do
    <<-EOS.strip_heredoc
      /*
       *= require admin-lte/bootstrap/css/bootstrap
       *= require admin-lte/dist/css/AdminLTE
       *= require admin-lte/dist/css/skins/skin-blue
       */
    EOS
  end

  append_to_file 'config/initializers/assets.rb' do
    <<-EOS.strip_heredoc
      \# AdminLTE
      Rails.application.config.assets.precompile += %w(
        admin_lte.js admin_lte.css
      )
    EOS
  end
end
