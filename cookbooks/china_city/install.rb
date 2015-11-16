route "mount ChinaCity::Engine => '/china_city'"

insert_into_file "config/initializers/assets.rb", " china_city/jquery.china_city.js\n",
                  after: "Rails.application.config.assets.precompile += %w(\n"

copy_file File.expand_path('../partial/_china_city.html.slim', __FILE__),
              "app/views/shared/_china_city.html.slim"
