generate 'rspec:install'

append_to_file '.rspec', '--format documentation'

insert_into_file 'spec/rails_helper.rb',
                 :after=>"RSpec.configure do |config|\n" do
  %q{config.include FactoryGirl::Syntax::Methods}.indent(2)
end

insert_into_file 'config/application.rb',
                 :after=>"class Application < Rails::Application\n" do
  <<-EOS.strip_heredoc.indent(4)
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_spece: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  EOS
end
