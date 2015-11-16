if yes?("是否安装主页(Y/N)")
  append_to_file 'Bowerfile' do
    <<-EOS.strip_heredoc

      asset "slick-carousel"
    EOS
  end
  rake 'bower:install'

  current_path = File.dirname(__FILE__)
  directory File.join(current_path, "assets/javascripts"), "app/assets/javascripts"
  directory File.join(current_path, "./assets/stylesheets"), "app/assets/stylesheets"
  directory File.join(current_path, "./assets/views/main"), "app/views"
  directory File.join(current_path, "./assets/views/layouts"), "app/views/layouts"
  directory File.join(current_path, "./assets/images/applicant"), "app/assets/images/applicant"

  generate :controller, "applicant/welcome index --no-controller-specs --skip-template-engine --skip-routes"

  insert_into_file "config/routes.rb", after: "Rails.application.routes.draw do\n" do
    <<-EOS.strip_heredoc

      scope module: :applicant do
        root 'welcome#index'
      end
    EOS
  end

  insert_into_file "config/initializers/assets.rb", after: "admin_lte.js admin_lte.css\n" do
    <<-EOS.strip_heredoc

      applicant.js applicant.css
    EOS
  end

  insert_into_file "app/controllers/application_controller.rb", after: "protect_from_forgery with: :exception\n" do
    <<-EOS.strip_heredoc

      layout :setup_layout

      private
        def setup_layout
          case params[:controller]
          when /^enterprise|^admin/
            'application'
          else
            'applicant'
          end
        end
    EOS
  end
end
