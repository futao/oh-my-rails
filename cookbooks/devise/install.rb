# @TODO
# 是否开启注册
# 是否开启锁定
# 是否添加用户名
# 是否添加手机

generate 'devise:install'
generate 'devise_invitable:install'
model_name = ask('please input model name')
generate "devise #{model_name}"
generate "devise_invitable #{model_name}"
generate :migration, "AddNameTo#{model_name.capitalize} name:string:uniq"
generate :migration, "AddMobileTo#{model_name.capitalize} mobile:string:uniq"
rake "db:migrate"
