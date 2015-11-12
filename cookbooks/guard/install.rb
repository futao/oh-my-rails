run "bundle exec guard init bundler"
run "bundle exec guard init migrate"
run "bundle exec guard init rspec"
run "bundle exec guard init livereload"

environment nil , env: 'development' do
  %q{config.middleware.insert_after ActionDispatch::Static, Rack::LiveReload}
end
