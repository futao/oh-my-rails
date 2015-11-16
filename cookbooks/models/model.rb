#工友模型和控制器
generate(:model, "labor", "enterprise:references", "name:string:index", "mobile:string:index",
                 "idcard:string:index", "gender:string:index", "birthday:date:index",
                 "channel:string:index", "province:string:index", "city:string:index",
                 "district:string:index", "state:string:index", "deleted_at:datetime:index")

#期望工作地和薪资模型
generate(:model, "labor_intention", "labor:references", "salary:string:index",
                 "province:string:index", "city:string:index", "district:string:index")

#期望职位模型
generate(:model, "position", "name:string:index", "name_seo:string:index",
                 "parent_id:integer:index", "lft:integer:index", "rgt:integer:index",
                 "deleted_at:datetime:index")

#行业模型
generate(:model, "industry", "name:string:index", "name_seo:string:index", "parent_id:integer:index",
                 "lft:integer:index", "rgt:integer:index", "deleted_at:datetime:index")

#公司模型
generate(:model, "company", "enterprise:references", "name:string:index", "province:string:index",
                 "city:string:index", "district:string:index", "address:string", "introduction:text",
                 "deleted_at:datetime:index")

#联系人模型
generate(:model, "contact", "enterprise:references", "name:string:index", "mobile:string:index",
                 "gender:string:index", "deleted_at:datetime:index")

#招聘职位模型
generate(:model, "job", "enterprise:references", "company:references", "contact:references",
                 "name:string:index", "quantity:integer", "gender:string:index", "age_min:integer:index",
                 "age_max:integer:index", "salary_basic:integer:index", "salary_min:integer:index",
                 "salary_max:integer:index", "state:string:index", "deleted_at:datetime:index")

#报名模型
generate(:model, "appointment", "job:references", "labor:references", "state:string:index")

#银行模型
generate(:model, "bank", "name:string", "published_at:datetime", "deleted_at:datetime")

#借记卡模型
generate(:model, "debit", "enterprise:references", "bank:references", "name:string:index",
                 "account:string:index", "deposit:string")

#充值模型
generate(:model, "CashIn", "ammount:decimal", "serial_outer:string", "serial_inner:string",
                 "state:string", "note:string", "deleted_at:datetime")

#提现模型
generate(:model, "CashOut", "ammount:decimal", "serial_outer:string", "serial_inner:string",
                 "state:string", "note:string", "deleted_at:datetime")

#招聘费模型
generate(:model, "recruitment_fee", "job:references", "gender:string", "amount:integer",
                 "day:integer", "deadline:integer")

#管理费模型
generate(:model, "management_fee", "job:references", "gender:string", "amount:integer",
                 "day:integer", "deadline:integer")

rake "db:migrate"
