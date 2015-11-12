if yes?("覆盖生成器scaffold?")
  directory File.join(File.dirname(__FILE__), 'lib/generators/slim/scaffold'), 'lib/generators/slim/scaffold'
  directory File.join(File.dirname(__FILE__), 'lib/templates/slim/scaffold'), 'lib/templates/slim/scaffold'
end
