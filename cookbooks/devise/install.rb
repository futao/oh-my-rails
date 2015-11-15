generate 'devise:install'

generate 'devise_invitable:install'

remove_file 'config/locales/devise.en.yml'

model_name = ask('请输入用户表名(空白跳过):')

if  model_name.present?
  generate "devise #{model_name}"
  generate "devise_invitable #{model_name}"
  generate :migration, "AddNameTo#{model_name.capitalize} name:string:index"
  generate :migration, "AddMobileTo#{model_name.capitalize} mobile:string:index"

  migrate_file = Dir["db/migrate/*"].grep(/.*_devise_create_#{model_name}.*/).first
  uncomment_lines migrate_file, /.*confirm.*/
  uncomment_lines migrate_file, /.*unlock.*|.*failed_attempts.*/
  rake "db:migrate"
  
end
