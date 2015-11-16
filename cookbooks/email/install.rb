inject_into_file 'config/application.rb',
  :after=>"class Application < Rails::Application\n" do
  <<-EOS.strip_heredoc.indent(4)
    # Action Mailer
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = false
    config.action_mailer.delivery_method = :smtp

    config.action_mailer.default charset: 'utf-8'
    config.action_mailer.default_options = {
      from:     '"淘帮忙团队" <notify@91tbm.com>',
      reply_to: '"淘帮忙问题反馈" <talk@91tbm.com>'
    }

    config.action_mailer.smtp_settings = {
      address:        'smtp.exmail.qq.com',
      port:           25,
      user_name:      ENV['EMAIL_PROVIDER_USERNAME'],
      password:       ENV['EMAIL_PROVIDER_PASSWORD'],
      authentication: :login,
      enable_starttls_auto: true
    }
  EOS
end


environment nil , env: 'development' do
  %q[config.action_mailer.default_url_options = { :host => 'localhost:3000' }]
end
environment nil , env: 'development' do
  %q{config.action_mailer.delivery_method = :letter_opener}
end


environment nil , env: 'staging' do
  %q[config.action_mailer.default_url_options = { :host => 'staging.91tbm.com' }]
end

environment nil , env: 'production' do
  %q[config.action_mailer.default_url_options = { :host => 'www.91tbm.com' }]
end


append_to_file '.env' do
  <<-EOS.strip_heredoc
    export EMAIL_PROVIDER_USERNAME=example
    export EMAIL_PROVIDER_PASSWORD=example
  EOS
end
