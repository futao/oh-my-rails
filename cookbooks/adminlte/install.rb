append_to_file 'Bowerfile' do
  <<-EOS.strip_heredoc

  asset 'font-awesome'
  asset 'ionicons'
  asset 'admin-lte'
  asset 'html5shiv'
  asset 'respond'
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


copy_file File.expand_path('../icheck/checkbox.js', __FILE__),
                          'app/assets/javascripts/plugins/checkbox.js'

# js
create_file 'app/assets/javascripts/admin_lte.js' do
  <<-EOS.strip_heredoc
    //= require jquery
    //= require admin-lte/bootstrap/js/bootstrap
    //= require admin-lte/dist/js/app
    //= require admin-lte/plugins/iCheck/icheck.min
    //= require plugins/checkbox
  EOS
end

# css
create_file 'app/assets/stylesheets/admin_lte.css' do
  <<-EOS.strip_heredoc
    /*
     *= require font-awesome/css/font-awesome
     *= require ionicons/css/ionicons
     *= require admin-lte/bootstrap/css/bootstrap
     *= require admin-lte/plugins/iCheck/all
     */
  EOS
end

append_to_file 'config/initializers/assets.rb' do
  <<-EOS.strip_heredoc
    \# AdminLTE
    Rails.application.config.assets.precompile += %w(
      admin_lte.js admin_lte.css
      admin-lte/dist/css/AdminLTE.css
      admin-lte/dist/css/skins/skin-blue.css
    )

    Rails.application.config.assets.precompile << %r(fontawesome-webfont\.(?:eot|svg|ttf|woff|woff2?)$)
    Rails.application.config.assets.precompile << %r(ionicons\.(?:eot|svg|ttf|woff)$)
    Rails.application.config.assets.precompile << 'html5shiv/dist/html5shiv.min.js'
    Rails.application.config.assets.precompile << 'respond/dest/respond.min.js'
  EOS
end
