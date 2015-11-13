generate 'devise:install'

generate 'devise_invitable:install'

model_name = ask('请输入用户表名(空白跳过): ')

if  model_name.present?
  generate "devise #{model_name}"
  generate "devise_invitable #{model_name}"

  if yes?('添加 name 字段? [Y/n]')
      generate :migration, "AddNameTo#{model_name.capitalize} name:string:index"
  end

  if yes?("添加 mobile 字段 ? [Y/n]")
      generate :migration, "AddMobileTo#{model_name.capitalize} mobile:string:index"
  end

  migrate_file = Dir["db/migrate/*"].grep(/.*_devise_create_#{model_name}.*/).first

  if yes?('开启邮箱验证? [Y/n]')
    uncomment_lines migrate_file, /.*confirm.*/
  end

  if yes?('开启账户锁定? [Y/n]')
    uncomment_lines migrate_file, /.*unlock.*|.*failed_attempts.*/
  end
  rake "db:migrate"
end
