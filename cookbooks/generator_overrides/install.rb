if yes?("覆盖生成器mailer && scaffold?")
  directory File.join(File.dirname(__FILE__), 'lib/generators/slim'), 'lib/generators/slim'
  directory File.join(File.dirname(__FILE__), 'lib/templates/slim'), 'lib/templates/slim'
end
